using FSK.APIService.Payment;
using FSK.APIService.Payment.Models;
using FSK.APIService.RequestModel;
using FSK.APIService.ResponseModel;
using FSK.Repository;
using FSK.Repository.Models;
using FSK.Service.Services.MyDispose;
using FSK.Service.Services.Systems;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
//using Microsoft.IdentityModel.Tokens;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdvertisementController : ControllerBase
    {

        private readonly UnitOfWork _unitOfWork;
        private readonly IVnPayService _vnPayService;

        public AdvertisementController(UnitOfWork unitOfWork, IVnPayService vnPayService)
        {
            _unitOfWork = unitOfWork;
            _vnPayService = vnPayService;
        }

        [HttpGet("GetPendingAds")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetPendingAds()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var ads = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.StatusId == 2);
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



        [HttpGet("AdsDeployByPage")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> AdsDeployByPage(int pageIndex = 0, int pageSize = 10)
        {

            BaseResponseModel response = new BaseResponseModel();


            try
            {
                UpdateExpired();
                
                var ads = (await _unitOfWork.AdvertisementRepository.GetPageAsync(pageIndex, pageSize)).Where(x => x.StatusId == 5 && x.IsActive != false);
                if (ads == null)
                {
                    response.Status = false;
                    response.Message = "There is no Deploying ads!";
                    return NotFound(response);
                }
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
                response.Status = true;
                response.Message = "Success";
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }




        }

        [HttpGet("AdsByPage")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetPageAds(int pageIndex = 0, int pageSize = 10)
        {

            BaseResponseModel response = new BaseResponseModel();


            try
            {
                UpdateExpired();

                var ads = (await _unitOfWork.AdvertisementRepository.GetPageAsync(pageIndex, pageSize)).Where(x => x.IsActive != false);
                if (ads == null)
                {
                    response.Status = false;
                    response.Message = "There is no ads found!";
                    return NotFound(response);
                }
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
                response.Status = true;
                response.Message = "Success";
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }




        }


        [HttpGet("GetAllDeploying")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetAllDeployingAds()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                UpdateExpired();
                var ads = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.StatusId == 5 && x.IsActive != false);
                if (ads == null)
                {
                    response.Status = false;
                    response.Message = "There is no Deploying ads!";
                    return NotFound(response);
                }
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
                response.Status = true;
                response.Message = "Success";
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
                UpdateExpired();
                var ads = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.IsActive != false);
                if (ads == null)
                {
                    response.Status = false;
                    response.Message = "There is no ads found!";
                    return NotFound(response);
                }
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
                response.Status = true;
                response.Message = "Success";
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
                if (ads == null)
                {
                    response.Status = false;
                    response.Message = "Advertisement not found!";
                    return NotFound(response);
                }
                await _unitOfWork.InteractRepository.CreateAsync(new Interact
                {
                    AdsId = id,
                    CreatedDate = DateTime.Now
                });
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
                var trasaction = await _unitOfWork.TransactionRepository.GetAllAsync();
                foreach (var item in trasaction)
                {
                    item.User = null;
                    item.Ads = null;
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

        [Authorize(Policy = "Member")]
        [HttpDelete("DeleteDraftById")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> DeleteDraftById(int id, int userId)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var ads = (await _unitOfWork.AdvertisementRepository.GetByIdAsync(id));

                if (ads == null)
                {
                    response.Status = false;
                    response.Message = "Advertisement not found!";
                    return NotFound(response);
                }
                if (ads.UserId != userId)
                {
                    response.Status = false;
                    response.Message = "Invalid User!";
                    return BadRequest(response);
                }
                if (ads.StatusId != 1)
                {
                    response.Status = false;
                    response.Message = "This function is use to delete draft Advertisement";
                    return BadRequest(response);
                }
                ads.StatusId = 3;
                ads.IsActive = false;

                response.Status = true;
                response.Message = "Draft removed successfully!";
                response.Data = await _unitOfWork.AdvertisementRepository.UpdateAsync(ads);
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }

        [Authorize(Policy = "Member")]
        [HttpPut("AdsSoldOut")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> AdsSoldOut(int id, int userId)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var ads = (await _unitOfWork.AdvertisementRepository.GetByIdAsync(id));

                if (ads == null)
                {
                    response.Status = false;
                    response.Message = "Advertisement not found!";
                    return NotFound(response);
                }
                if (ads.UserId != userId)
                {
                    response.Status = false;
                    response.Message = "Invalid User!";
                    return BadRequest(response);
                }
                if (ads.StatusId != 5)
                {
                    response.Status = false;
                    response.Message = "This function is for deploying Advertisement";
                    return BadRequest(response);
                }
                ads.StatusId = 7;
                ads.IsActive = true;

                response.Status = true;
                response.Message = "Update successfully!";
                response.Data = await _unitOfWork.AdvertisementRepository.UpdateAsync(ads);
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }

        [Authorize(Policy = "Member")]
        [HttpPut("AdsSoldBack")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> AdsSoldBack(int id, int userId)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var ads = (await _unitOfWork.AdvertisementRepository.GetByIdAsync(id));

                if (ads == null)
                {
                    response.Status = false;
                    response.Message = "Advertisement not found!";
                    return NotFound(response);
                }
                if (ads.UserId != userId)
                {
                    response.Status = false;
                    response.Message = "Invalid User!";
                    return BadRequest(response);
                }
                if (ads.StatusId != 7)
                {
                    response.Status = false;
                    response.Message = "This function is for deploying Advertisement";
                    return BadRequest(response);
                }
                ads.StatusId = 5;
                ads.IsActive = true;

                response.Status = true;
                response.Message = "Update successfully!";
                response.Data = await _unitOfWork.AdvertisementRepository.UpdateAsync(ads);
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }


        [HttpGet("GetRecAds")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetAdsElement(int Elementid)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                UpdateExpired();

                var AdsList = await _unitOfWork.AdvertisementRepository.GetAllAsync();

                var RecAds = AdsList.Where(x => x.ElementId == Elementid && x.StatusId == 5 && x.IsActive != false).ToList();



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

                if (RecAds.Count == 0)
                {
                    response.Status = false;
                    response.Message = "No Ads Recommended.";
                    return BadRequest(response);
                }

                var output = _unitOfWork.AdvertisementRepository.Shuffle(RecAds);

                response.Status = true;
                response.Message = "Success";
                response.Data = output.Take(3);

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
                response.Data = (await _unitOfWork.PackageRepository.GetAllAsync()).Where(x => x.IsActive != false);
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }

        [Authorize(Policy = "Member")]
        [HttpPost("CreateDraftedAd")]
        public async Task<IActionResult> CreateDraftedAd([FromBody] AdvertisementRequestModel model)
        {
            //try
            //{
                    if (model == null || model.UserId == 0)
                    {
                        return BadRequest("Invalid request data");
                    }

                var user = await _unitOfWork.UserRepository.GetByIdAsync(model.UserId);
                var currentDate = DateTime.UtcNow;

                ////Putting this for checking user's role, should be the authentication's work but cant implement that right now
                ////Khúc này t sửa lại thành ID nếu thấy sai thì sửa
                //if (user == null || user.RoleId != 3)
                //{
                //    return BadRequest("Invalid user or user is not a member");
                //}

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
                PaymentStatus = false,
                CreatedDate = DateTime.Now,
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

        private async Task<int> CreateDraftedAdV2([FromBody] AdvertisementRequestModel model)
        {
            try
            {
                if (model == null || model.UserId == 0)
                {
                    return -1;
                }

                var user = await _unitOfWork.UserRepository.GetByIdAsync(model.UserId);

                //Putting this for checking user's role, should be the authentication's work but cant implement that right now
                //Khúc này t sửa lại thành ID nếu thấy sai thì sửa
                if (user == null || user.RoleId != 3)
                {
                    return -2;
                }

                var draftId = _unitOfWork.StatusRepository.GetAll().Where(x => x.Status1 == "Drafted").First().StatusId;
                // Check the number of existing drafted ads for this user
                var existingDraftedAdsCount = await _unitOfWork.AdvertisementRepository.CountAsync(
                    a => a.UserId == model.UserId && a.StatusId == draftId);

                if (existingDraftedAdsCount >= 3)
                {
                    return -3;
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
                    PaymentStatus = false,
                    CreatedDate = DateTime.Now,
                };

                await _unitOfWork.AdvertisementRepository.CreateAsync(advertisement);
                var newAds = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.UserId == model.UserId).Last();
                await _unitOfWork.SaveChangesAsync();

                return newAds.AdsId;
            }
            catch (Exception err)
            {
                return 0;
            }
            
        }

        [Authorize(Policy = "Member")]
        [HttpPut("UpdateAd")]
        public async Task<IActionResult> UpdateAd([FromBody] UpdateAdvertisementRequestModel model)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                if (model == null || model.AdvertisementId == 0 || model.UserId == 0)
                {
                    response.Status = false;
                    response.Message = "Invalid request data";
                    return BadRequest(response);
                }

                var advertisement = await _unitOfWork.AdvertisementRepository.GetByIdAsync(model.AdvertisementId);

                if (advertisement == null)
                {
                    response.Status = false;
                    response.Message = "Advertisement not found";
                    return NotFound(response);
                }

                // Check if the user is the owner of the advertisement
                if (advertisement.UserId != model.UserId)
                {
                    response.Status = false;
                    response.Message = "You don't have permission to update this advertisement";
                    return Forbid(response.Message);
                }

                // Check if the advertisement is in a state that allows updates (e.g., 'Drafted')
                var allowedStatusIds = await _unitOfWork.StatusRepository.GetByIdAsync(1);

                if (allowedStatusIds.StatusId != advertisement.StatusId)
                {
                    response.Status = false;
                    response.Message = "This advertisement cannot be updated in its current state";
                    return BadRequest(response);
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
                    advertisement.AdsTypeId = model.AdsTypeId.Value;
                    hasChanges = true;
                }
                if (model.Content != null && model.Content != advertisement.Content)
                {
                    advertisement.Content = model.Content;
                    hasChanges = true;
                }
                if (model.ElementId != null && model.ElementId != advertisement.ElementId)
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
                    response.Status = true;
                    response.Message = "Advertisement updated successfully";
                    response.Data = advertisement;
                    return Ok(response);
                }
                else
                {
                    response.Status = true;
                    response.Message = "No changes detected";
                    response.Data = advertisement;
                    return Ok(response);
                }
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
                
            }

            
        }

        private async Task<int> UpdateAdv2([FromBody] UpdateAdvertisementRequestModel model)
        {

            try
            {
                if (model == null || model.AdvertisementId == 0 || model.UserId == 0)
                {
                    return -1;
                }

                var advertisement = await _unitOfWork.AdvertisementRepository.GetByIdAsync(model.AdvertisementId);

                if (advertisement == null)
                {
                    return -2;
                }

                // Check if the user is the owner of the advertisement
                if (advertisement.UserId != model.UserId)
                {
                    return -3;
                }

                // Check if the advertisement is in a state that allows updates (e.g., 'Drafted')
                var allowedStatusIds = await _unitOfWork.StatusRepository.GetByIdAsync(1);

                if (allowedStatusIds.StatusId != advertisement.StatusId)
                {
                    return -4;
                }

                bool hasChanges = false;

                // Update fields if they are provided and different from current values
                if (model.Title != null && model.Title != advertisement.Title)
                {
                    advertisement.Title = model.Title;
                    hasChanges = true;
                }
                if (model.AdsTypeId != 0 && model.AdsTypeId != advertisement.AdsTypeId)
                {
                    advertisement.AdsTypeId = model.AdsTypeId.Value;
                    hasChanges = true;
                }
                if (model.Content != null && model.Content != advertisement.Content)
                {
                    advertisement.Content = model.Content;
                    hasChanges = true;
                }
                if (model.ElementId != 0 && model.ElementId != advertisement.ElementId)
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
                    return 1;
                }
                else
                {
                    return 1;
                }
            }
            catch (Exception err)
            {
                return -999;
            }


        }

        [HttpGet("GetAdsByUser")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetAdsUser(int userid)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var user = await _unitOfWork.UserRepository.GetByIdAsync(userid);
                if (user == null)
                {
                    response.Status = false;
                    response.Message = "This user is invalid.";
                    return BadRequest(response);
                }

                var ads = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.UserId == userid && x.IsActive != false).ToList();
                foreach (var item in ads)
                {
                    item.User = null;
                }
                var package = await _unitOfWork.PackageRepository.GetAllAsync();
                foreach (var item in package)
                {
                    item.Advertisements = null;
                }
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
                var trasaction = await _unitOfWork.TransactionRepository.GetAllAsync();
                foreach (var item in trasaction)
                {
                    item.Ads = null;
                    item.User = null;
                }

                if (ads == null)
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


        [HttpPost("CreatePayment")]
        public async Task<IActionResult> CreatePaymentUrl(AdsPaymentModel ads)
        {
            BaseResponseModel response = new BaseResponseModel();

            Advertisement item;

            if (!ads.AdsId.HasValue || ads.AdsId == 0)
            {
                AdvertisementRequestModel createModel = new AdvertisementRequestModel
                {
                    AdsTypeId = ads.AdsTypeId,
                    ElementId = ads.ElementId,
                    Content = ads.Content,
                    Title = ads.Title,
                    UserId = ads.UserId,
                    ImageUrl = ads.ImageUrl
                };

                var checkCreate = CreateDraftedAdV2(createModel).Result;

                if (checkCreate <= 0)
                {
                    response.Status = false;

                    if (checkCreate == -1) response.Message = "Invalid data for create.";
                    else if (checkCreate == -2) response.Message = "Invalid user or user is not a member";
                    else if (checkCreate == -3) response.Message = "You have reached the maximum limit of 3 drafted advertisements. " +
                            "Please submit or delete an existing draft before creating a new one.";
                    else response.Message = "Something wrong while creating an Advertisement.";

                    return BadRequest(response);
                }

                item = await _unitOfWork.AdvertisementRepository.GetByIdAsync(checkCreate);

            }
            else
            {
                UpdateAdvertisementRequestModel updateContent = new UpdateAdvertisementRequestModel {
                    AdvertisementId = ads.AdsId.Value, 
                    AdsTypeId = ads.AdsTypeId,
                    Content = ads.Content,
                    ElementId = ads.ElementId,
                    ImageUrl = ads.ImageUrl,
                    Title = ads.Title,
                    UserId = ads.UserId
                };

                var checkUpdate = UpdateAdv2(updateContent).Result;

                 if (checkUpdate <= 0)
                 {
                     response.Status = false;
                    if (checkUpdate == -1) response.Message = "Invalid data for update";
                    else if (checkUpdate == -2) response.Message = "Advertisement not found";
                    else if (checkUpdate == -3) response.Message = "You don't have permission to update this advertisement";
                    else if (checkUpdate == -4) response.Message = "This advertisement cannot be updated in its current state";
                    else response.Message = "Something wrong while updating an Advertisement.";
                     return BadRequest(response);
                 }

                item = await _unitOfWork.AdvertisementRepository.GetByIdAsync(ads.AdsId.Value);

            }

            // Update + Calculate to create Payment

            if (item == null)
            {
                response.Status = false;
                response.Message = "Item didn't found";
                return BadRequest(response);
            }

            item.PackageId = ads.PackageId;

            await _unitOfWork.AdvertisementRepository.UpdateAsync(item);

            item.Package = await _unitOfWork.PackageRepository.GetByIdAsync(item.PackageId.Value);

            item.AdsType = await _unitOfWork.AdsTypeRepository.GetByIdAsync(item.AdsTypeId);

            PaymentInformationModel model = new PaymentInformationModel
            {
                Name = $"Ad's Title: {item.Title}.",
                Amount = item.Package.Price.Value * ads.Quantity,
                OrderDescription = $"PackageType: {item.Package.PackageName}, Price: {item.Package.Price}, Quantity: {ads.Quantity}. Duration: {ads.Quantity*item.Package.Duration}. Id: {item.AdsId},{ads.Quantity}",
                OrderType = item.AdsType.TypeName
            };

            var url = _vnPayService.CreatePaymentUrl(model, HttpContext);



            response.Status = true;
            response.Message = "Success";
            response.Data = url;


            return Ok(response);
        }

        [HttpGet("CheckData")]
        public async Task<IActionResult> PaymentCallback()
        {

            await using var resource = new MyResource();

            try
            {
                await resource.PerformAsyncOperation();


                var paymentStatus = _vnPayService.PaymentExecute(Request.Query);


                var lastIndex = paymentStatus.OrderDescription.Split(": ").Last();
                var listIndex = lastIndex.Split(",");

                int AdsId = int.Parse(listIndex.First());
                int Quantity = int.Parse(listIndex.Last());


                var Ads = await _unitOfWork.AdvertisementRepository.GetByIdAsync(AdsId);
                var Package = await _unitOfWork.PackageRepository.GetByIdAsync(Ads.PackageId.Value);


                var checkInput = await _unitOfWork.TransactionRepository.CreateIdentityAsync(new Transaction
                {
                    TransactionId = int.Parse(paymentStatus.TransactionId),
                    UserId = Ads.UserId,
                    AdsId = Ads.AdsId,
                    PackageId = Ads.PackageId.Value,
                    TransactionDetail = paymentStatus.OrderDescription,
                    PaymentMethod = paymentStatus.PaymentMethod,
                    TransactionDate = DateTime.Now,
                    TotalPrice = Package.Price.Value*Quantity,
                    Duration = Package.Duration*Quantity
                });

                if (checkInput != 0)
                {
                    Ads.StatusId = 2;
                    Ads.PaymentStatus = true;
                    Ads.Duration = Package.Duration * Quantity;

                    await _unitOfWork.AdvertisementRepository.UpdateAsync(Ads);

                    var transaction = await _unitOfWork.TransactionRepository.GetByIdAsync(int.Parse(paymentStatus.TransactionId));


                    //Trả về thanh toán thành công ở đây.
                    String successUrl = "http://localhost:5173/ads/create/package/result";
                    return Redirect(successUrl);
                }
                else
                {
                    //Trả về lỗi lưu hóa đơn ở đây
                    String failedInvoiceUrl = "http://localhost:5173";
                    return Redirect(failedInvoiceUrl);
                }
                


            }
            catch (Exception err)
            {
                //Trả về trang thanh toán thất bại.
                String failedPayment = "http://localhost:5173";
                return Redirect(failedPayment);

            }

        }

        //[HttpGet("Test")]
        private async Task<IActionResult> Test(bool status, string message)
        {


            if(status == true)
            {
                return Ok(message);
            }

            else
            {
                return BadRequest(message);
            }
                

        }

        //[HttpGet("Test2")]
        private async void Test2()
        {

            Response.Redirect("http://localhost:5173");

        }

        [HttpGet("GetType")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetAdsType()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";

                var adsType = await _unitOfWork.AdsTypeRepository.GetAllAsync();
                foreach (var item in adsType)
                {
                    item.Advertisements = null;
                }

                response.Data = adsType;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }

        [HttpGet("GetView")]
        public async Task<ActionResult<IEnumerable<Advertisement>>> GetView(int adsId)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var ads = await _unitOfWork.AdvertisementRepository.GetByIdAsync(adsId);
                if (ads == null)
                {
                    response.Status = false;
                    response.Message = "Advertisement not found!";
                    return NotFound(response);
                }

                var totalView = (await _unitOfWork.InteractRepository.GetAllAsync()).Where(x => x.AdsId == adsId).Count();
                
                
                response.Status = true;
                response.Message = "Success";
                response.Data = totalView;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }

        private void UpdateExpired()
        {
            var today = DateTime.Now.Date;
            var DeployingAds = _unitOfWork.AdvertisementRepository.GetAll().Where(x => x.StatusId == 5);
            foreach (var item in DeployingAds)
            {
                if (item.ExpiredDate.Value.Date.CompareTo(today) <= 0)
                    item.StatusId = 6;
            }
            _unitOfWork.AdvertisementRepository.Save();
        }



    }
}