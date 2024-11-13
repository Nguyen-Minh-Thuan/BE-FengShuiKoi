using FSK.APIService.ResponseModel;
using FSK.Repository;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    //[Authorize(Policy = "Admin")]
    public class DashboardSearch : ControllerBase
    {

        private readonly UnitOfWork _unitOfWork;

        public DashboardSearch(UnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        [HttpGet("GetFengShuiFromTo")]
        public async Task<IActionResult> GetFengShuiFromTo([FromQuery] DateTime FromDate, [FromQuery] DateTime ToDate)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var totalDate = GetFromTo(FromDate, ToDate);

                List<DashboardResponseModel> output = new List<DashboardResponseModel>();

                foreach (var date in totalDate)
                {
                    var data = (await _unitOfWork.GeneralRepository.GetAllAsync()).Where(x => x.CreatedDate.Date == date.Date);
                    output.Add(new DashboardResponseModel
                    {
                        date = $"{date}",
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

        [HttpGet("GetTotalAdsFromTo")]
        public async Task<IActionResult> GetTotalAdsFromTo([FromQuery] DateTime FromDate, [FromQuery] DateTime ToDate)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var totalDate = GetFromTo(FromDate, ToDate);

                List<DashboardResponseModel> output = new List<DashboardResponseModel>();

                foreach (var date in totalDate)
                {
                    var data = (await _unitOfWork.AdvertisementRepository.GetAllAsync()).Where(x => x.CreatedDate.Date == date.Date && x.StatusId != 1);
                    output.Add(new DashboardResponseModel
                    {
                        date = $"{date}",
                        total = data.Count(),
                        deploying = data.Where(x => x.StatusId == 5).Count(),
                        expired = data.Where(x => x.StatusId == 6).Count()
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

        [HttpGet("GetUserFromTo")]
        public async Task<IActionResult> GetUserFromTo([FromQuery] DateTime FromDate, [FromQuery] DateTime ToDate)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var totalDate = GetFromTo(FromDate, ToDate);

                List<DashboardResponseModel> output = new List<DashboardResponseModel>();

                foreach (var date in totalDate)
                {
                    var data = (await _unitOfWork.UserRepository.GetAllAsync()).Where(x => x.CreatedDate.Date == date.Date);
                    output.Add(new DashboardResponseModel
                    {
                        date = $"{date}",
                        total = data.Count()
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

        [HttpGet("GetIncomeFromTo")]
        public async Task<IActionResult> GetIncomeFromTo([FromQuery] DateTime FromDate, [FromQuery] DateTime ToDate)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var totalDate = GetFromTo(FromDate, ToDate);

                List<DashboardResponseModel> output = new List<DashboardResponseModel>();

                foreach (var date in totalDate)
                {
                    var data = (await _unitOfWork.TransactionRepository.GetAllAsync()).Where(x => x.TransactionDate.Date == date.Date);
                    output.Add(new DashboardResponseModel
                    {
                        date = $"{date}",
                        income = data.Select(x => x.TotalPrice).Sum()
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

        private List<DateTime> GetFromTo(DateTime from, DateTime to)
        {
            var dates = new List<DateTime>();

            DateTime nextDate = to.AddDays(1);

            // Loop from the first day of the month until we hit the next month, moving forward a day at a time
            for (var date = from; date.Date != nextDate.Date; date = date.AddDays(1))
            {
                dates.Add(date);
            }

            return dates;

        }
    }
}
