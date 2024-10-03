using Microsoft.AspNetCore.Http;
using FSK.Service.Services;
using Microsoft.AspNetCore.Mvc;
using FSK.Repository;
using FSK.Repository.Models;
using FSK.APIService.RespondModel;
using Microsoft.IdentityModel.Tokens;

namespace FSK.APIService.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FengShuiController : ControllerBase
    {
        private readonly FengShuiService _fengShuiService;
        private readonly UnitOfWork _unitOfWork;

        public FengShuiController(FengShuiService fengShuiService, UnitOfWork unitOfWork)
        {
            _fengShuiService = fengShuiService;
            _unitOfWork = unitOfWork;
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
        public IActionResult CalculateCungPhi([FromQuery] DateTime birthday, [FromQuery] string gender)
        {
            try
            {
                var result = _fengShuiService.CalculateCungPhi(birthday, gender);
                return Ok(new { message = $"Cung Phi for year {birthday} and gender {gender} is: {result}" });
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

        [HttpGet("CalculateDir")]
        public async Task<ActionResult<Element>> CalculateDirection( DateTime birthday,  string gender)
        {
            BaseResponseModel response = new BaseResponseModel();

            response.Status = true;
            response.Message = "Success";

            
            var elementID = _fengShuiService.CalculateFengShui(birthday, gender);

            var element = await _unitOfWork.ElementRepository.GetByIdAsync(elementID);
            var pond = await _unitOfWork.PondRepository.GetAllAsync();
            var shape = await _unitOfWork.ShapeRepository.GetAllAsync();
            foreach (Shape item in shape)
            {
                item.Ponds = null;
            }

            var kuaID = _fengShuiService.CalculateCungPhi(birthday, gender);

            var kua = await _unitOfWork.KuaRepository.GetByIdAsync(elementID);
            var auspicious = await _unitOfWork.AuspiciousRepository.GetAllAsync();
            var inauspicoous = await _unitOfWork.InauspiciousRepository.GetAllAsync();
            var direction = await _unitOfWork.DirectionRepository.GetAllAsync();
            foreach (var item in direction)
            {
                item.Auspicious = null;
                item.Inauspicious = null;
            }

            response.Data = new { Direction = kua, PondShape = element };


            if (response.Data == null)
            {
                response.Status = false;
                response.Message = "User not found";
                return BadRequest(response);
            }

            return Ok(response);
        }

        [HttpGet("Koi")]
        public async Task<ActionResult<Element>> GetKoi(DateTime birthday, string gender)
        {
            BaseResponseModel response = new BaseResponseModel();

            response.Status = true;
            response.Message = "Success";

            var elementID = _fengShuiService.CalculateFengShui(birthday, gender);

            var element = await _unitOfWork.ElementRepository.GetByIdAsync(elementID);
            var elementColor = await _unitOfWork.ElementColorRepository.GetAllAsync();

            var color = await _unitOfWork.ColorRepository.GetAllAsync();
            foreach (Color n in color)
            {
                n.ElementColors = null;
            }
            var patternColor = await _unitOfWork.PatternColorRepository.GetAllAsync();
            foreach (PatternColor n in patternColor)
            {

                n.Color = null;
            }

            var pattern = await _unitOfWork.PatternRepository.GetAllAsync();
            foreach (Pattern n in pattern)
            {
                n.PatternColors = null;
                //foreach (PatternColor m in n.PatternColors)
                //{
                //    m.Color = await _unitOfWork.ColorRepository.GetByIdAsync(m.ColorId);
                //}
            }
            var variety = await _unitOfWork.VarietyRepository.GetAllAsync();
            foreach (Variety n in variety)
            {
                n.Patterns = null;
            }

            //var pond = await _unitOfWork.PondRepository.GetAllAsync();
            //var shape = await _unitOfWork.ShapeRepository.GetAllAsync();
            //foreach (Shape item in shape)
            //{
            //    item.Ponds = null;
            //}
            var getData = element;
            response.Data = element;


            if (response.Data == null)
            {
                response.Status = false;
                response.Message = "User not found";
                return BadRequest(response);
            }

            return Ok(response);
        }

        [HttpGet("Testing")]
        public async Task<ActionResult<Element>> Testing()
        {
            BaseResponseModel response = new BaseResponseModel();

            response.Status = true;
            response.Message = "Success";


            var patterns = await _unitOfWork.PatternRepository.GetAllAsync();
            var variety = await _unitOfWork.VarietyRepository.GetAllAsync();
            //foreach (var n in variety)
            //{
            //    n.Patterns.Clear();
            //}
            var patternColor = await _unitOfWork.PatternColorRepository.GetAllAsync();
            var color = await _unitOfWork.ColorRepository.GetAllAsync();





            var element = await _unitOfWork.ElementRepository.GetByIdAsync(2);

            var elementColor = await _unitOfWork.ElementColorRepository.GetAllAsync();
            foreach (var n in elementColor)
            {
                n.Element = null;
            }

            
            var test = variety.Select(x => new VarietyRespondModel
            {
                VarietyId = x.VarietyId,
                VarietyName = x.VarietyName,
                Description = x.Description,
                Patterns = x.Patterns.Select(y => new PatternRespondModel
                {
                    PatternId = y.PatternId,
                    PatternName = y.PatternName,
                    ImageUrl = y.ImageUrl,
                    VarietyId = y.VarietyId,
                    PatternColors = y.PatternColors.Select(z => new PatternColorRespondModel
                    {
                        ColorId = z.ColorId,
                        PatternId = z.PatternId,
                        PcolorId = z.PatternId,
                        Values = z.Values
                    }).ToList(),
                }).ToList(),
                TotalPattern = x.Patterns.Count(),
            }).ToList();
            

            response.Data = new { test };


            //var pond = await _unitOfWork.PondRepository.GetAllAsync();
            //var shape = await _unitOfWork.ShapeRepository.GetAllAsync();
            //foreach (Shape item in shape)
            //{
            //    item.Ponds = null;
            //}


            if (response.Data == null)
            {
                response.Status = false;
                response.Message = "User not found";
                return BadRequest(response);
            }

            return Ok(response);
        }

    }

}
