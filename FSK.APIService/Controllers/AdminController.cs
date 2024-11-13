using FSK.APIService.ResponseModel;
using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;
using static System.Runtime.InteropServices.JavaScript.JSType;

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
            //advertisement.StatusId = 5;

            //advertisement.StartedDate = DateTime.Now;
            //advertisement.ExpiredDate = advertisement.StartedDate.Value.AddDays(advertisement.Duration.Value);

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
                var total = list.Where(x => x.StatusId != 1).Count();
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
                var total = list.Where(x => x.StatusId != 1).Count();
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
                DashboardResponseModel output = new DashboardResponseModel
                {
                    date = today.Year.ToString(),
                    total = list.Count(),
                    pond = list.Where(x => x.KuaId != null && x.ElementId == null).Count(),
                    koi = list.Where(x => x.ElementId != null && x.KuaId == null).Count(),
                    point = list.Where(x => x.ElementId != null && x.KuaId != null).Count(),
                };
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

        [HttpGet("AdsCheckAllById")]
        public async Task<IActionResult> AdsCheckAllById(int id)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var list = (await _unitOfWork.InteractRepository.GetAllAsync()).Where(x => x.AdsId == id).Select(x => 
                new Interact
                {
                    InteractId = x.InteractId,
                    AdsId = x.AdsId,
                    CreatedDate = x.CreatedDate.Date,
                }).ToList();
                response.Status = true;
                response.Message = "Success";
                response.Data = list;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("GetFengShuiCheck")]
        public async Task<IActionResult> GetFengShuiCheck()
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var list = (await _unitOfWork.GeneralRepository.GetAllAsync()).Select(x => new General
                {
                    GeneralId = x.GeneralId,
                    ElementId = x.ElementId,
                    KuaId = x.KuaId,
                    CreatedDate = x.CreatedDate.Date,
                }).ToList();
                response.Status = true;
                response.Message = "Success";
                response.Data = new 
                { 
                    total = list, 
                    kua = list.Where(x => x.KuaId != null && x.ElementId == null), 
                    element = list.Where(x => x.KuaId == null && x.ElementId != null), 
                    pointing = list.Where(x => x.KuaId != null && x.ElementId != null),
                };
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("WeeklyAdsCheck")]
        public async Task<IActionResult> WeeklyAdsCheck(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var Monday = GetMonday(skip);
                var Sunday = Monday.AddDays(6);
                var list = (await _unitOfWork.InteractRepository.GetAllAsync()).Where(x => x.CreatedDate.Date >= Monday.Date && x.CreatedDate.Date <= Sunday).Select(x => new Interact
                {
                    InteractId = x.InteractId,
                    AdsId = x.AdsId,
                    CreatedDate = x.CreatedDate.Date,
                }).ToList();
                response.Status = true;
                response.Message = "Success";
                response.Data = new { list = list, total = list.Count() , FromDate = Monday.Date, ToDate  = Sunday.Date};
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("WeeklyFengShuiCheck")]
        public async Task<IActionResult> WeeklyFengShuiCheck(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var Monday = GetMonday(skip);
                var Sunday = Monday.AddDays(6);
                var list = (await _unitOfWork.GeneralRepository.GetAllAsync()).Where(x => x.CreatedDate.Date >= Monday.Date && x.CreatedDate.Date <= Sunday).Select(x => new General
                {
                    GeneralId = x.GeneralId,
                    ElementId = x.ElementId,
                    KuaId = x.KuaId,
                    CreatedDate = x.CreatedDate.Date,
                }).ToList();
                response.Status = true;
                response.Message = "Success";
                response.Data = new { list = list, total = list.Count(), FromDate = Monday.Date, ToDate = Sunday.Date };
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return NotFound(response);
            }
        }

        [HttpGet("GetWeeklyList")]
        public async Task<IActionResult> GetWeeklyListGeneral(int skip)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var Monday = GetMonday(skip*7);
                var Sunday = Monday.AddDays(6);

                var Week = GetDatesInWeek(Monday, Sunday);
                List<DashboardResponseModel> output = new List<DashboardResponseModel>();

                foreach (var date in Week)
                {
                    var data = (await _unitOfWork.GeneralRepository.GetAllAsync()).Where(x => x.CreatedDate.Date == date.Date);
                    output.Add(new DashboardResponseModel
                    {
                        date = date.ToString(),
                        total = data.Count(),
                        pond = data.Where(x => x.KuaId != null && x.ElementId == null).Count(),
                        koi = data.Where(x => x.KuaId == null && x.ElementId != null).Count(),
                        point = data.Where(x => x.KuaId != null && x.ElementId != null).Count()
                    });
                }
                

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

        [HttpGet("GetMonthList")]
        public async Task<IActionResult> GetMonthListGeneral(int year, int month)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {

                var Month = GetDatesInMonth(year,month);

                List<DashboardResponseModel> output = new List<DashboardResponseModel>();

                foreach (var date in Month)
                {
                    var data = (await _unitOfWork.GeneralRepository.GetAllAsync()).Where(x => x.CreatedDate.Date == date.Date);
                    output.Add(new DashboardResponseModel
                    {
                        date = date.ToString(),
                        total = data.Count(),
                        pond = data.Where(x => x.KuaId != null && x.ElementId == null).Count(),
                        koi = data.Where(x => x.KuaId == null && x.ElementId != null).Count(),
                        point = data.Where(x => x.KuaId != null && x.ElementId != null).Count()
                    });
                }


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

        [HttpGet("GetMonthlyList")]
        public async Task<IActionResult> GetMonthlyListGeneral(int year)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {

                var Year = GetMonthInYear(year);

                List<DashboardResponseModel> output = new List<DashboardResponseModel>();

                foreach (var date in Year)
                {
                    var data = (await _unitOfWork.GeneralRepository.GetAllAsync()).Where(x => x.CreatedDate.Date.Month == date.Date.Month);
                    output.Add(new DashboardResponseModel
                    {
                        date = $"{date.Month}/{date.Year}",
                        total = data.Count(),
                        pond = data.Where(x => x.KuaId != null && x.ElementId == null).Count(),
                        koi = data.Where(x => x.KuaId == null && x.ElementId != null).Count(),
                        point = data.Where(x => x.KuaId != null && x.ElementId != null).Count()
                    });
                }


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

        

        private DateTime GetMonday(int skip)
        {
            var today = DateTime.Now.AddDays(skip);
            var ouput = (today.DayOfWeek == DayOfWeek.Sunday) ? today.AddDays(-6) :
                        (today.DayOfWeek == DayOfWeek.Tuesday) ? today.AddDays(-1) :
                        (today.DayOfWeek == DayOfWeek.Wednesday) ? today.AddDays(-2) :
                        (today.DayOfWeek == DayOfWeek.Thursday) ? today.AddDays(-3) :
                        (today.DayOfWeek == DayOfWeek.Friday) ? today.AddDays(-4) :
                        (today.DayOfWeek == DayOfWeek.Saturday) ? today.AddDays(-5) :
                        today;
            return ouput;
        }

        private List<DateTime> GetDatesInWeek(DateTime monday, DateTime sunday)
        {
            var dates = new List<DateTime>();

            DateTime newWeek = sunday.AddDays(1);

            // Loop from the first day of the month until we hit the next month, moving forward a day at a time
            for (var date = monday; date.Date != newWeek.Date; date = date.AddDays(1))
            {
                dates.Add(date);
            }

            return dates;

        }

        private List<DateTime> GetDatesInMonth(int year, int month)
        {
            var dates = new List<DateTime>();

            // Loop from the first day of the month until we hit the next month, moving forward a day at a time
            for (var date = new DateTime(year, month, 1); date.Month == month; date = date.AddDays(1))
            {
                dates.Add(date);
            }

            return dates;

        }

        private List<DateTime> GetMonthInYear(int year)
        {
            var dates = new List<DateTime>();

            // Loop from the first day of the month until we hit the next month, moving forward a day at a time
            for (var date = new DateTime(year, 1, 1); date.Year == year; date = date.AddMonths(1))
            {
                dates.Add(date);
            }

            return dates;

        }


    }
}