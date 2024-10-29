using FSK.APIService.ResponseModel;
using FSK.Repository;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Policy = "Admin")]
    public class DashboardSearch : ControllerBase
    {

        private readonly UnitOfWork _unitOfWork;

        public DashboardSearch(UnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
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
