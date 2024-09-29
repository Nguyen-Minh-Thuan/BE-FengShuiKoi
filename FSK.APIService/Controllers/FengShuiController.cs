using Microsoft.AspNetCore.Http;
using FSK.Repository.Services;
using Microsoft.AspNetCore.Mvc;

namespace FSK.APIService.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FengShuiController : ControllerBase
    {
        private readonly FengShuiService _fengShuiService;

        public FengShuiController(FengShuiService fengShuiService)
        {
            _fengShuiService = fengShuiService;
        }

        [HttpGet("calculate")]
        public IActionResult CalculateFengShui([FromQuery] DateTime birthday, [FromQuery] string gender)
        {
            try
            {
                var result = _fengShuiService.CalculateFengShui(birthday, gender);
                return Ok(new { message = result });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { error = "An unexpected error occurred." });
            }
        }

        [HttpGet("calculate-cung-phi")]
        public IActionResult CalculateCungPhi([FromQuery] int year, [FromQuery] string gender)
        {
            try
            {
                var result = _fengShuiService.CalculateCungPhi(year, gender);
                return Ok(new { message = $"Cung Phi for year {year} and gender {gender} is: {result}" });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { error = ex.Message });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { error = "An unexpected error occurred." });
            }
        }
    }

}
