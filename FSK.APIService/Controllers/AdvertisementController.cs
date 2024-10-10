using FSK.APIService.RequestModel;
using FSK.APIService.RespondModel;
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

        [HttpPost("Create")]
        public async Task<IActionResult> CreateAdvertisement([FromBody] CreateAdvertisementRequestModel model)
        {
            //try
            //{
                    if (model == null || model.UserId == 0)
                    {
                        return BadRequest("Invalid request data");
                    }

                var user = await _unitOfWork.UserRepository.GetByIdAsync(model.UserId);
                var currentDate = DateTime.UtcNow;

                //Putting this for checking user's role, should be the authentication's work but cant implement that right now
                //Khúc này t sửa lại thành ID nếu thấy sai thì sửa
                if (user == null || user.RoleId != 3)
                {
                    return BadRequest("Invalid user or user is not a member");
                }

                var package = await _unitOfWork.PackageRepository.GetByIdAsync(model.PackageId);
                if (package == null)
                {
                    return BadRequest("Invalid package selected");
                }

                var advertisement = new Advertisement
                {
                    UserId = model.UserId,
                    AdsTypeId = model.AdsTypeId,
                    PackageId = model.PackageId,
                    Title = model.Title,
                    Content = model.Content,
                    StatusId = 2,
                    ElementId = model.ElementId,
                    StartedDate = currentDate,
                    ExpiredDate = currentDate.AddDays(30), // Assuming a 30-day duration for easier to debug
                    ImageUrl = model.ImageUrl,
                    PaymentStatus = true
                };

                await _unitOfWork.AdvertisementRepository.CreateAsync(advertisement);
                await _unitOfWork.SaveChangesAsync();

                // Create a transaction for the advertisement
                var transaction = new Transaction
                {
                    UserId = model.UserId,
                    AdsId = advertisement.AdsId,
                    PackageId = model.PackageId,
                    FromDate = currentDate,
                    ToDate = advertisement.ExpiredDate,
                    TransactionDate = currentDate,
                    PaymentMethod = "QR Pay",
                    TotalPrice = package.Price
                };

                await _unitOfWork.TransactionRepository.CreateAsync(transaction);
                await _unitOfWork.SaveChangesAsync();

                return Ok(new { message = "Advertisement created and pending approval", advertisementId = advertisement.AdsId });
             
            //catch (Exception ex)
            //{
            //    // Log the exception details
            //    return StatusCode(500, "An error occurred while creating the advertisement. Please try again later.");
            //}
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

                if(ads.IsNullOrEmpty())
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
