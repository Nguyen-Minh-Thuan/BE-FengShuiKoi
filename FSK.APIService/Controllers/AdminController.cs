using FSK.APIService.ResponseModel;
using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FSK.APIService.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize(Policy = "Admin")]
    public class AdminController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;

        public AdminController(UnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        [HttpPost("ApproveAdvertisement/{advertisementId}")]
        public async Task<IActionResult> ApproveAdvertisement(int advertisementId)
        {
            var advertisement = await _unitOfWork.AdvertisementRepository.GetByIdAsync(advertisementId);

            if (advertisement == null)
            {
                return NotFound("Advertisement not found");
            }

            if (advertisement.PaymentStatus == false)
            {
                return BadRequest("Payment must be completed before approval");
            }
            if (advertisement.StatusId != 2)
            {
                return BadRequest("This Advertisement are not allow to update Status");
            }
            //Approved
            advertisement.StatusId = 4;

            //Smth should have been here but idk for now :D


            //Deploying
            advertisement.StatusId = 5;
            advertisement.StartedDate = DateTime.Now;
            advertisement.ExpiredDate = advertisement.StartedDate.Value.AddDays(advertisement.Duration.Value);

            await _unitOfWork.SaveChangesAsync();

            return Ok(new { message = "Advertisement approved successfully" });
        }

        [HttpPost("DeclineAdvertisement/{advertisementId}")]
        public async Task<IActionResult> DeclineAdvertisement(int advertisementId, [FromBody] string reason)
        {
            var advertisement = await _unitOfWork.AdvertisementRepository.GetByIdAsync(advertisementId);

            if (advertisement == null)
            {
                return NotFound("Advertisement not found");
            }

            if (advertisement.StatusId != 2)
            {
                return BadRequest("This Advertisement are not allow to update Status");
            }

            advertisement.StatusId = 3;
            advertisement.Reason = reason;

            // add a new property to the Advertisement model to store the decline reason, or not?
            // advertisement.DeclineReason = reason;

            await _unitOfWork.SaveChangesAsync();

            // This should be the refund proccess if payment was made, but since payment wasnt completed yet, imma comment this out
            //if (advertisement.PaymentStatus == true)
            //{
            //}

            return Ok(new { message = "Advertisement declined" });
        }

        [HttpGet("GetDeployingAds")]
        public async Task<IActionResult> GetDeployingAds()
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var advertisements = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.StatusId == 5).Count();

                if (advertisements == 0)
                {
                    response.Status = false;
                    response.Message = "Advertisement not found";
                    response.Data = 0;
                    return NotFound(response);
                }

                response.Status = true;
                response.Message = "Success";
                response.Data = advertisements;
                return Ok(response);

            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }



        }


        [HttpGet("GetExpiredAds")]
        public async Task<IActionResult> GetExpiredAds()
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var advertisements = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.StatusId == 6).Count();

                if (advertisements == 0)
                {
                    response.Status = false;
                    response.Message = "Advertisement not found";
                    response.Data = 0;
                    return NotFound(response);
                }

                response.Status = true;
                response.Message = "Success";
                response.Data = advertisements;
                return Ok(response);

            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }



        }

        [HttpGet("TotalAds")]
        public async Task<IActionResult> TotalAds()
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var advertisements = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.StatusId != 1).Count();

                if (advertisements == 0)
                {
                    response.Status = false;
                    response.Message = "Advertisement not found";
                    response.Data = 0;
                    return NotFound(response);
                }

                response.Status = true;
                response.Message = "Success";
                response.Data = advertisements;
                return Ok(response);

            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }



        }

        [HttpGet("TotalUser")]
        public async Task<IActionResult> TotalUser()
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var users = (await _unitOfWork.UserRepository.GetAllAsync()).Count();

                if (users == 0)
                {
                    response.Status = false;
                    response.Message = "There is no User founded";
                    response.Data = 0;
                    return NotFound(response);
                }

                response.Status = true;
                response.Message = "Success";
                response.Data = users;
                return Ok(response);

            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }



        }

        [HttpGet("TotalRegisteredUser")]
        public async Task<IActionResult> TotalRegisteredUser()
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var users = (await _unitOfWork.UserRepository.GetAllAsync()).Count();

                response.Status = true;
                response.Message = "Success";
                response.Data = users;
                return Ok(response);

            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }



        }

        [HttpGet("DailyUser")]
        public async Task<IActionResult> DailyUser(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var today = DateTime.Today.AddMonths(skip);
                var list = (await _unitOfWork.UserRepository.GetAllAsync()).Where(x => x.CreatedDate.Date == today.Date && x.CreatedDate.Month == today.Month && x.CreatedDate.Year == today.Year);
                var total = list.Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = total;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("MonthlyUser")]
        public async Task<IActionResult> MonthlyUser(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var today = DateTime.Today.AddMonths(skip);
                var list = (await _unitOfWork.UserRepository.GetAllAsync()).Where(x => x.CreatedDate.Month == today.Month && x.CreatedDate.Year == today.Year);
                var total = list.Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = total;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("YearlyUser")]
        public async Task<IActionResult> YearlyUser(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var today = DateTime.Today.AddYears(skip);
                var list = (await _unitOfWork.UserRepository.GetAllAsync()).Where(x => x.CreatedDate.Year == today.Year);
                var total = list.Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = total;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("DailyAds")]
        public async Task<IActionResult> DailyAds(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var today = DateTime.Today.AddMonths(skip);
                var list = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.CreatedDate.Date == today.Date && x.CreatedDate.Month == today.Month && x.CreatedDate.Year == today.Year);
                var total = list.Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = total;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("MonthlyAds")]
        public async Task<IActionResult> MonthlyAds(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var today = DateTime.Today.AddMonths(skip);
                var list = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.CreatedDate.Month == today.Month && x.CreatedDate.Year == today.Year);
                var total = list.Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = total;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("YearlyAds")]
        public async Task<IActionResult> YearlyAds(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var today = DateTime.Today.AddYears(skip);
                var list = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.CreatedDate.Year == today.Year);
                var total = list.Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = total;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("DailyFengshui")]
        public async Task<IActionResult> DailyFengshui(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var today = DateTime.Today.AddDays(skip);
                var list = (await _unitOfWork.GeneralRepository.GetAllAsync()).Where(x => x.CreatedDate.Date == today.Date &&
                x.CreatedDate.Month == today.Month && x.CreatedDate.Year == today.Year);
                var total = list.Count();
                var dir = list.Where(x => x.KuaId != null && x.ElementId == null).Count();
                var element = list.Where(x => x.ElementId != null && x.KuaId ==null).Count();
                var pointing = list.Where(x => x.ElementId != null && x.KuaId != null).Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = new { total = total, totalDir = dir, totalElement = element, totalPoint = pointing };
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("MonthlyFengshui")]
        public async Task<IActionResult> MonthlyFengshui(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var today = DateTime.Today.AddMonths(skip);
                var list = (await _unitOfWork.GeneralRepository.GetAllAsync()).Where(x => x.CreatedDate.Month == today.Month && x.CreatedDate.Year == today.Year);
                var total = list.Count();
                var dir = list.Where(x => x.KuaId != null && x.ElementId == null).Count();
                var element = list.Where(x => x.ElementId != null && x.KuaId == null).Count();
                var pointing = list.Where(x => x.ElementId != null && x.KuaId != null).Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = new { total = total, totalDir = dir, totalElement = element, totalPoint = pointing };
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("YearlyFengshui")]
        public async Task<IActionResult> YearlyFengshui(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var today = DateTime.Today.AddYears(skip);
                var list = (await _unitOfWork.GeneralRepository.GetAllAsync()).Where(x => x.CreatedDate.Year == today.Year);
                var total = list.Count();
                var dir = list.Where(x => x.KuaId != null && x.ElementId == null).Count();
                var element = list.Where(x => x.ElementId != null && x.KuaId == null).Count();
                var pointing = list.Where(x => x.ElementId != null && x.KuaId != null).Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = new { total = total, totalDir = dir, totalElement = element, totalPoint = pointing };
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        /*
        [HttpPost("AdsWeekCheck")]
        public async Task<IActionResult> UserWeekCheck(int AdsId, int week)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                int jump = 7;

                var Today = DateTime.Now.AddDays(jump*week);

                var ads = (await _unitOfWork.AdvertisementRepository.GetAllAsync());
                if (ads == null)
                {
                    response.Status = false;
                    response.Message = "There is no User founded";
                    response.Data = 0;
                    return NotFound(response);
                }
                DateTime monday = ads.ElementAt(0).CreatedDate.Date;
                DateTime sunday = DateTime.Today.Date;
                bool check = false;
                var Days = ads.GroupBy(x => x.CreatedDate.Date);
                foreach (var item in Days)
                {
                    if (Today <= item.Key)
                        Today = item.Key;

                    if (item.Key.DayOfWeek == DayOfWeek.Monday)
                        monday = item.Key;

                    if (Today.Date == item.Key.Date)
                        check = true;

                    sunday = item.Key;

                    if (item.Key.DayOfWeek == DayOfWeek.Sunday && check == true)
                        break;
                }
                var output = ads.Where(x => x.CreatedDate.Date >= monday.Date && x.CreatedDate.Date <= sunday.Date).Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = output;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }



        }
        */

        [HttpGet("AdsMonthlyCheck")]
        public async Task<IActionResult> AdsMonthlyCheck(int AdsId, int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {

                var Today = DateTime.Now.AddMonths(skip);
                var list = (await _unitOfWork.InteractRepository.GetAllAsync()).Where(x => x.AdsId == AdsId && x.CreatedDate.Month == Today.Month && x.CreatedDate.Year == Today.Year);
                var total = list.Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = total;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }



        }

        [HttpGet("AdsYearlyCheck")]
        public async Task<IActionResult> AdsYearlyCheck(int AdsId, int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {

                var Today = DateTime.Now.AddYears(skip);
                var list = (await _unitOfWork.InteractRepository.GetAllAsync()).Where(x => x.CreatedDate.Year == Today.Year);
                var total = list.Count();
                response.Status = true;
                response.Message = "Success";
                response.Data = total;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }



        }




    }
}