using Microsoft.AspNetCore.Http;
using FSK.Service.Services;
using Microsoft.AspNetCore.Mvc;
using FSK.Repository;
using FSK.Repository.Models;
using FSK.APIService.RespondModel;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Extensions.FileSystemGlobbing.Internal;
using System.Reflection;
using FSK.APIService.RequestModel;
using Azure.Core;

namespace FSK.APIService.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FengShuiController : ControllerBase
    {
        private readonly FengShuiService _fengShuiService;
        private readonly UnitOfWork _unitOfWork;
        private static Double _defaultPoint = 4;

        public FengShuiController(FengShuiService fengShuiService, UnitOfWork unitOfWork)
        {
            _fengShuiService = fengShuiService;
            _unitOfWork = unitOfWork;
        }

        //[HttpGet("calculate")]
        private IActionResult CalculateFengShui([FromQuery] DateTime birthday, [FromQuery] string gender)
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

        //[HttpGet("calculate-cung-phi")]
        private IActionResult CalculateCungPhi([FromQuery] DateTime birthday, [FromQuery] string gender)
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
        public async Task<ActionResult<Direction>> CalculateDirection([FromQuery] DateTime birthday, [FromQuery] string gender)
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


        [HttpGet("RecKoi")]
        public async Task<ActionResult<Element>> RecKoi([FromQuery] DateTime birthday, [FromQuery] string gender)
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
            //var color = await _unitOfWork.ColorRepository.GetAllAsync();

            var elementID = _fengShuiService.CalculateFengShui(birthday, gender);

            var element = await _unitOfWork.ElementRepository.GetByIdAsync(elementID);

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
                        PcolorId = z.PcolorId,
                        Values = z.Values,
                        ComputeValues = z.Values * (Testing2(elementID, z.ColorId)),
                    }).ToList(),
                    PatternPoint = y.PatternColors.Sum(z => z.Values * (Testing2(elementID, z.ColorId))),
                }).ToList(),
                TotalPattern = x.Patterns.Count(),
            }).ToList();


            var recQuantity = await _unitOfWork.ElementQuantityRepository.GetAllAsync();


            response.Data = new { Variety = test , RecQuantity = recQuantity.Where(x => x.ElementId == elementID) };


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

        private double TotalPoint(ICollection<PatternColor> patternColors)
        {
            double total = 0;

            foreach (var item in patternColors)
            {
                total += item.Values;
            }

            return total;
        }

        private double Testing(int elementId, int shapeId)
        {
            try
            {

                var test = (_unitOfWork.PondRepository.GetAll()).Where(x => x.ElementId == elementId && x.ShapeId == shapeId).FirstOrDefault();

                if (test != null)
                    return 1;
                else
                    return 0;
            }
            catch (Exception)
            {
                return 0;
            }
            //(await _unitOfWork.ElementQuantityRepository.GetAllAsync()).Where(x => x.ElementId == elementID && x.Quantity == patterns.Count()).ToList();
        }

        private double Testing2(int elementId, int id)
        {
            try
            {
                double test = _unitOfWork.ElementColorRepository.GetAll().Where(x => x.ElementId == elementId && x.ColorId == id).First().Values;
                return test+_defaultPoint;
            }
            catch (Exception)
            {
                return 1+ _defaultPoint;
            }
            //(await _unitOfWork.ElementQuantityRepository.GetAllAsync()).Where(x => x.ElementId == elementID && x.Quantity == patterns.Count()).ToList();
        }

        private double Testing3(int elementID ,int count)
        {
            try
            {

                var test = (_unitOfWork.ElementQuantityRepository.GetAll()).Where(x => x.ElementId == elementID && x.Quantity == count%10).FirstOrDefault();

                if (test != null)
                    return 1;
                else 
                    return 0;
            }
            catch (Exception)
            {
                return 0;
            }
            //(await _unitOfWork.ElementQuantityRepository.GetAllAsync()).Where(x => x.ElementId == elementID && x.Quantity == patterns.Count()).ToList();
        }

        private double Testing4(int kuaId, int dirId)
        {
            try
            {

                var test = (_unitOfWork.AuspiciousRepository.GetAll()).Where(x => x.KuaId == kuaId && x.DirectionId == dirId).FirstOrDefault();

                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
            //(await _unitOfWork.ElementQuantityRepository.GetAllAsync()).Where(x => x.ElementId == elementID && x.Quantity == patterns.Count()).ToList();
        }


        [HttpPost("Pointing")]
        public async Task<ActionResult<Element>> Pointing([FromQuery] DateTime birthday, [FromQuery] string gender, int shapeId, int dirId, List<PatternRequestModel> request)
        {
            BaseResponseModel response = new BaseResponseModel();
            try
            {
                var elementId = _fengShuiService.CalculateFengShui(birthday, gender);

                var element = await _unitOfWork.ElementRepository.GetByIdAsync(elementId);

                var elementColor = await _unitOfWork.ElementColorRepository.GetAllAsync();
                foreach (var n in elementColor)
                {
                    n.Element = null;
                }

                var kuaId = _fengShuiService.CalculateCungPhi(birthday, gender);

                //Pond Pointing

                var bonusPond = Testing(elementId, shapeId);

                var bonusDirection = Testing4(kuaId,dirId);


                //Koi Pointing


                List<Pattern> patterns = new List<Pattern>();
                foreach (var item in request)
                {
                    patterns.Add(_unitOfWork.PatternRepository.GetById(item.PatternId));
                }
                var patternColor = await _unitOfWork.PatternColorRepository.GetAllAsync();

                var Bonus = Testing3(elementId, patterns.Count());
                
                

                var test = patterns.Select(x => new PatternRespondModel
                {
                    PatternId = x.PatternId,
                    PatternName = x.PatternName,
                    ImageUrl = x.ImageUrl,
                    PatternColors = x.PatternColors.Select(z => new PatternColorRespondModel
                    {
                        ColorId = z.ColorId,
                        PatternId = z.PatternId,
                        PcolorId = z.PcolorId,
                        Values = z.Values,
                        ComputeValues = (z.Values * Testing2(elementId, z.ColorId)),
                    }).ToList(),
                    PatternPoint = x.PatternColors.Sum(z => z.Values * Testing2(elementId, z.ColorId)) + Bonus + bonusPond + bonusDirection,
                }).ToList();

                double total = 0;
                foreach (var pattern in test)
                {
                    total += pattern.PatternPoint;
                }


                response.Status = true;
                response.Message = "Success";
                response.Data = new { KoiPoint = test , TotalPoint = total/test.Count };
                return Ok(response);
            }
            catch (Exception ex)
            {
                response.Status = false;
                response.Message = ex.ToString();
                return BadRequest(response);
            }

        }

        [HttpGet("GetPondDir")]
        public async Task<ActionResult<IEnumerable<Direction>>> GetAllDir()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.DirectionRepository.GetAllAsync();
                
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }




        }

        [HttpGet("GetPondShape")]
        public async Task<ActionResult<IEnumerable<Shape>>> GetAllShape()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.ShapeRepository.GetAllAsync();

                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }




        }


        [HttpGet("GetKois")]
        public async Task<ActionResult<Variety>> GetKois()
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";



                var variety = await _unitOfWork.VarietyRepository.GetAllAsync();
                var pattern = await _unitOfWork.PatternRepository.GetAllAsync();
                foreach (var item in pattern)
                {
                    item.Variety = null;
                }
                var patternColor = await _unitOfWork.PatternColorRepository.GetAllAsync();
                foreach(var item in patternColor)
                {
                    item.Pattern = null;
                }
                var color = await _unitOfWork.ColorRepository.GetAllAsync();
                foreach (var item in color)
                {
                    item.PatternColors = null;
                    item.ElementColors = null;
                }

                response.Data = variety.Select(x => new VarietyRespondModel
                {
                    VarietyId = x.VarietyId,
                    VarietyName = x.VarietyName,
                    ImageUrl = x.ImageUrl,
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
                            PcolorId = z.PcolorId,
                            ColorName = _unitOfWork.ColorRepository.GetById(z.ColorId).Name,
                        }).ToList(),
                    }).ToList(),
                }).ToList();





                if (response.Data == null)
                {
                    response.Status = false;
                    response.Message = "Kois not found";
                    return BadRequest(response);
                }

                return Ok(response);

            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return BadRequest(response);
            }

            
        }

    }

}
