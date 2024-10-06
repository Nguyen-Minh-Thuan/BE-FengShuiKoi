using FSK.APIService.RequestModel;
using FSK.APIService.RespondModel;
using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

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
                response.Data = await _unitOfWork.AdvertisementRepository.GetPageAsync(pageIndex, pageSize);
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
                response.Data = await _unitOfWork.AdvertisementRepository.GetAllAsync();
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
                response.Data = await _unitOfWork.AdvertisementRepository.GetByIdAsync(id);
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
            if (model == null || model.UserId == 0)
            {
                return BadRequest("Invalid request data");
            }

            var user = await _unitOfWork.UserRepository.GetByIdAsync(model.UserId);
            
            //Putting this for checking user's role, should be the authentication's work but cant implement that right now
            if (user == null || user.Role != 3)
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
                PackageId = model.PackageId,
                Title = model.Title,
                Content = model.Content,
                Status = "Pending",
                ElementId = model.ElementId,
                ExpiredDate = DateTime.Now.AddDays(30), // Assuming a 30-day duration for easier to debug
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
                FromDate = DateTime.Now,
                ToDate = advertisement.ExpiredDate,
                PaymentMethod = "QR Pay",
                TransactionDate = DateTime.Now,
                TotalPrice = package.Price
            };

            await _unitOfWork.TransactionRepository.CreateAsync(transaction);
            await _unitOfWork.SaveChangesAsync();

            return Ok(new { message = "Advertisement created and pending approval", advertisementId = advertisement.AdsId });
        }

    }
}
