using FSK.APIService.RequestModel;
using FSK.APIService.ResponseModel;
using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdvertisementController : ControllerBase
    {

        private readonly UnitOfWork _unitOfWork;
        //private readonly DatabaseContext _Dbcontext;

        public AdvertisementController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;
        //public AdvertisementController(DatabaseContext Dbcontext) => _Dbcontext = Dbcontext;


        [HttpGet("AdsByPage")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetPageAds(int pageIndex = 0, int pageSize = 10)
        {

            BaseResponseModel response = new BaseResponseModel();


            try
            {
                response.Status = true;
                response.Message = "Success";
                var ads = await _unitOfWork.AdvertisementRepository.GetPageAsync(pageIndex, pageSize);
                var status = await _unitOfWork.StatusRepository.GetAllAsync();
                foreach (var item in status)
                {
                    item.Advertisements = null;
                }
                var type = await _unitOfWork.AdsTypeRepository.GetAllAsync();
                foreach (var item in type)
                {
                    item.Advertisements = null;
                }

                response.Data = ads;

                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }




        }


        [HttpGet("GetAll")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetAds()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var ads = await _unitOfWork.AdvertisementRepository.GetAllAsync();
                var status = await _unitOfWork.StatusRepository.GetAllAsync();
                foreach (var item in status)
                {
                    item.Advertisements = null;
                }
                var type = await _unitOfWork.AdsTypeRepository.GetAllAsync();
                foreach (var item in type)
                {
                    item.Advertisements = null;
                }
                var user = await _unitOfWork.UserRepository.GetAllAsync();
                foreach (var item in user)
                {
                    item.Advertisements = null;
                    item.Transactions = null;
                }
                var role = await _unitOfWork.RoleRepository.GetAllAsync();
                foreach (var item in role)
                {
                    item.Users = null;
                }

                response.Data = ads;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }


        [HttpGet("GetAdsById")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetAdsId(int id)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var ads = await _unitOfWork.AdvertisementRepository.GetByIdAsync(id);

                var status = await _unitOfWork.StatusRepository.GetAllAsync();
                foreach (var item in status)
                {
                    item.Advertisements = null;
                }
                var type = await _unitOfWork.AdsTypeRepository.GetAllAsync();
                foreach (var item in type)
                {
                    item.Advertisements = null;
                }

                response.Data = ads;

                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }


        [HttpGet("GetPackage")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetPackage()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.PackageRepository.GetAllAsync();
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }


        [HttpPost("CreateDraftedAd")]
        public async Task<IActionResult> CreateDraftedAd([FromBody] AdvertisementRequestModel model)
        {
            if (model == null || model.UserId == 0)
            {
                return BadRequest("Invalid request data");
            }

            var user = await _unitOfWork.UserRepository.GetByIdAsync(model.UserId);
            var currentDate = DateTime.UtcNow;

            if (user == null || user.RoleId != 3)
            {
                return BadRequest("Invalid user or user is not a member");
            }

            var draftId = _unitOfWork.StatusRepository.GetAll().Where(x => x.Status1 == "Drafted").First().StatusId;
            // Check the number of existing drafted ads for this user
            var existingDraftedAdsCount = await _unitOfWork.AdvertisementRepository.CountAsync(
                a => a.UserId == model.UserId && a.StatusId == draftId);

            if (existingDraftedAdsCount >= 3)
            {
                return BadRequest("You have reached the maximum limit of 3 drafted advertisements. Please submit or delete an existing draft before creating a new one.");
            }

            var advertisement = new Advertisement
            {
                UserId = model.UserId,
                AdsTypeId = model.AdsTypeId,
                Title = model.Title,
                Content = model.Content,
                StatusId = draftId,
                ElementId = model.ElementId,
                ImageUrl = model.ImageUrl,
                PaymentStatus = false
            };

            await _unitOfWork.AdvertisementRepository.CreateAsync(advertisement);
            await _unitOfWork.SaveChangesAsync();

            return Ok(new { message = "Advertisement draft created successfully", advertisementId = advertisement.AdsId });
        }

        //[HttpPost("SubmitAd")]
        //public async Task<IActionResult> SubmitAd([FromBody] SubmitAdvertisementRequestModel model)
        //{
        //    if (model == null || model.AdvertisementId == 0)
        //    {
        //        return BadRequest("Invalid request data");
        //    }

        //    var advertisement = await _unitOfWork.AdvertisementRepository.GetByIdAsync(model.AdvertisementId);

        //    if (advertisement == null)
        //    {
        //        return NotFound("Advertisement not found");
        //    }

        //    bool hasChanges = false;

        //    // Update the existing ad only if there are changes
        //    if (model.Title != null && model.Title != advertisement.Title)
        //    {
        //        advertisement.Title = model.Title;
        //        hasChanges = true;
        //    }
        //    if (model.Content != null && model.Content != advertisement.Content)
        //    {
        //        advertisement.Content = model.Content;
        //        hasChanges = true;
        //    }
        //    if (model.ElementId.HasValue && model.ElementId != advertisement.ElementId)
        //    {
        //        advertisement.ElementId = model.ElementId;
        //        hasChanges = true;
        //    }
        //    if (model.ImageUrl != null && model.ImageUrl != advertisement.ImageUrl)
        //    {
        //        advertisement.ImageUrl = model.ImageUrl;
        //        hasChanges = true;
        //    }

        //    // Only proceed if there are changes or if the ad is still in 'Drafted' status
        //    var draftId = _unitOfWork.StatusRepository.GetAll().Where(x => x.Status1 == "Drafted").First().StatusId;
        //    if (hasChanges || advertisement.StatusId == draftId)
        //    {
        //        var pendingId = _unitOfWork.StatusRepository.GetAll().Where(x => x.Status1 == "Pending").First().StatusId;
        //        advertisement.StatusId = pendingId;

        //        await _unitOfWork.AdvertisementRepository.UpdateAsync(advertisement);

        //        // Create a transaction for the advertisement
        //        var transaction = new Transaction
        //        {
        //            UserId = advertisement.UserId,
        //            AdsId = advertisement.AdsId,
        //            PackageId = advertisement.PackageId.Value,
        //            FromDate = advertisement.StartedDate.Value,
        //            ToDate = advertisement.ExpiredDate.Value,
        //            TransactionDate = DateTime.UtcNow,
        //            PaymentMethod = "QR Pay",
        //            TotalPrice = (await _unitOfWork.PackageRepository.GetByIdAsync(advertisement.PackageId.Value)).Price
        //        };

        //        await _unitOfWork.TransactionRepository.CreateAsync(transaction);
        //        await _unitOfWork.SaveChangesAsync();

        //        // Process payment
        //        bool paymentSuccessful = await ProcessPayment(transaction.TransactionId);

        //        if (paymentSuccessful)
        //        {
        //            advertisement.PaymentStatus = true;
        //            await _unitOfWork.AdvertisementRepository.UpdateAsync(advertisement);

        //            //transaction.Status = "Completed";
        //            await _unitOfWork.TransactionRepository.UpdateAsync(transaction);

        //            await _unitOfWork.SaveChangesAsync();

        //            return Ok(new { message = "Advertisement submitted and payment processed successfully", advertisementId = advertisement.AdsId });
        //        }
        //        else
        //        {
        //            // Payment failed, revert the status to 'Drafted'
        //            advertisement.StatusId = draftId;
        //            await _unitOfWork.AdvertisementRepository.UpdateAsync(advertisement);
        //            await _unitOfWork.SaveChangesAsync();

        //            return BadRequest("Payment failed. The advertisement is saved as a draft.");
        //        }
        //    }
        //    else
        //    {
        //        return Ok(new { message = "No changes detected. Advertisement remains unchanged.", advertisementId = advertisement.AdsId });
        //    }
        //}

        //private async Task<bool> ProcessPayment(int transactionId)
        //{
        //    // Implement payment processing logic here, or somewhere
        //    // This is a placeholder that always returns true
        //    await Task.Delay(1000); // Simulating some processing time
        //    return true;
        //}

        [HttpPut("UpdateAd")]
        public async Task<IActionResult> UpdateAd([FromBody] UpdateAdvertisementRequestModel model)
        {
            if (model == null || model.AdvertisementId == 0 || model.UserId == 0)
            {
                return BadRequest("Invalid request data");
            }

            var advertisement = await _unitOfWork.AdvertisementRepository.GetByIdAsync(model.AdvertisementId);

            if (advertisement == null)
            {
                return NotFound("Advertisement not found");
            }

            // Check if the user is the owner of the advertisement
            if (advertisement.UserId != model.UserId)
            {
                return Forbid("You don't have permission to update this advertisement");
            }

            // Check if the advertisement is in a state that allows updates (e.g., 'Drafted' or 'Declined')
            var allowedStatusIds = new[] {
                 _unitOfWork.StatusRepository.GetByIdAsync(1).Id,
                 _unitOfWork.StatusRepository.GetByIdAsync(3).Id
            };

            if (!allowedStatusIds.Contains(advertisement.StatusId))
            {
                return BadRequest("This advertisement cannot be updated in its current state");
            }

            bool hasChanges = false;

            // Update fields if they are provided and different from current values
            if (model.Title != null && model.Title != advertisement.Title)
            {
                advertisement.Title = model.Title;
                hasChanges = true;
            }
            if (model.AdsTypeId != null && model.AdsTypeId != advertisement.AdsTypeId)
            {
                advertisement.AdsTypeId = model.AdsTypeId;
                hasChanges = true;
            }
            if (model.Content != null && model.Content != advertisement.Content)
            {
                advertisement.Content = model.Content;
                hasChanges = true;
            }
            if (model.ElementId.HasValue && model.ElementId != advertisement.ElementId)
            {
                advertisement.ElementId = model.ElementId.Value;
                hasChanges = true;
            }
            if (model.ImageUrl != null && model.ImageUrl != advertisement.ImageUrl)
            {
                advertisement.ImageUrl = model.ImageUrl;
                hasChanges = true;
            }

            if (hasChanges)
            {
                await _unitOfWork.AdvertisementRepository.UpdateAsync(advertisement);
                await _unitOfWork.SaveChangesAsync();
                return Ok(new { message = "Advertisement updated successfully", advertisementId = advertisement.AdsId });
            }
            else
            {
                return Ok(new { message = "No changes detected", advertisementId = advertisement.AdsId });
            }
        }

        [HttpGet("GetAdsByUser")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetAdsUser(int userid)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var listUser = (await _unitOfWork.UserRepository.GetAllAsync()).Select(x => x.UserId).ToList();
                if (!listUser.Contains(userid))
                {
                    response.Status = false;
                    response.Message = "This user is invalid.";
                    return BadRequest(response);
                }

                var ads = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.UserId == userid).ToList();
                var status = await _unitOfWork.StatusRepository.GetAllAsync();
                foreach (var item in status)
                {
                    item.Advertisements = null;
                }
                var type = await _unitOfWork.AdsTypeRepository.GetAllAsync();
                foreach (var item in type)
                {
                    item.Advertisements = null;
                }

                if (ads.IsNullOrEmpty())
                {
                    response.Status = false;
                    response.Message = "There is nothing to return.";
                    return BadRequest(response);
                }
                else
                {
                    response.Status = true;
                    response.Message = "Success";
                    response.Data = ads;
                }

                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }
        }



    }
}