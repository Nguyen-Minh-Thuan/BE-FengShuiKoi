﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using FSK.Repository;
using FSK.Repository.Models;
using FSK.APIService.ResponseModel;
//using Microsoft.IdentityModel.Tokens;
using Microsoft.Extensions.FileSystemGlobbing.Internal;
using System.Reflection;
using FSK.APIService.RequestModel;
//using Azure.Core;
using FSK.Service.Services.Systems;
using System.Security.Cryptography;
using System;

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
        public async Task<ActionResult<Direction>> CalculateDirection([FromQuery] DateTime birthday, [FromQuery] string gender)
        {
            BaseResponseModel response = new BaseResponseModel();

            response.Status = true;
            response.Message = "Success";

            
            var elementID = _fengShuiService.CalculateFengShui(birthday, gender);
            var kuaID = _fengShuiService.CalculateCungPhi(birthday, gender);
            if (kuaID == 5)
            {
                kuaID = gender.ToLower() == "male" ? 2 : 8;
            }
            await _unitOfWork.GeneralRepository.CreateAsync(new General
            {
                CreatedDate = DateTime.Now,
                KuaId = kuaID,
                ElementId = null
            });
            var element = await _unitOfWork.ElementRepository.GetByIdAsync(elementID);
            var pond = await _unitOfWork.PondRepository.GetAllAsync();
            var shape = await _unitOfWork.ShapeRepository.GetAllAsync();
            foreach (Shape item in shape)
            {
                item.Ponds = null;
            }

            

            var kua = await _unitOfWork.KuaRepository.GetByIdAsync(kuaID);
            var auspicious = await _unitOfWork.AuspiciousRepository.GetAllAsync();
            var inauspicous = await _unitOfWork.InauspiciousRepository.GetAllAsync();
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
                response.Message = "Error while calculate!";
                return BadRequest(response);
            }

            return Ok(response);
        }


        [HttpGet("RecKoi")]
        public async Task<ActionResult<Element>> RecKoi([FromQuery] DateTime birthday, [FromQuery] string gender)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";


                var patterns = await _unitOfWork.PatternRepository.GetAllAsync();
                var variety = (await _unitOfWork.VarietyRepository.GetAllAsync()).Where(x => x.IsActive != false);
                //foreach (var n in variety)
                //{
                //    n.Patterns.Clear();
                //}
                var patternColor = await _unitOfWork.PatternColorRepository.GetAllAsync();
                //var color = await _unitOfWork.ColorRepository.GetAllAsync();

                var elementID = _fengShuiService.CalculateFengShui(birthday, gender);

                var element = await _unitOfWork.ElementRepository.GetByIdAsync(elementID);
                if (element == null)
                {
                    response.Status = false;
                    response.Message = "Cannot calculate your element!";
                    return NotFound(Response);
                }

                await _unitOfWork.GeneralRepository.CreateAsync(new General
                {
                    CreatedDate = DateTime.Now,
                    ElementId = elementID,
                    KuaId = null,
                });

                var elementColor = await _unitOfWork.ElementColorRepository.GetAllAsync();
                foreach (var n in elementColor)
                {
                    n.Element = null;
                }


                var test = variety.Select(x => new VarietyResponseModel
                {
                    VarietyId = x.VarietyId,
                    VarietyName = x.VarietyName,
                    Description = x.Description,
                    Patterns = x.Patterns.Select(y => new PatternResponseModel
                    {
                        PatternId = y.PatternId,
                        PatternName = y.PatternName,
                        ImageUrl = y.ImageUrl,
                        VarietyId = y.VarietyId,
                        PatternColors = y.PatternColors.Select(z => new PatternColorResponseModel
                        {
                            ColorId = z.ColorId,
                            PatternId = z.PatternId,
                            PcolorId = z.PcolorId,
                            Values = z.Values,
                            ComputeValues = z.Values * (Testing2(elementID, z.ColorId)),
                            IsActive = z.IsActive
                        }).Where(x => x.IsActive != false).ToList(),
                        PatternPoint = y.PatternColors.Where(x => x.IsActive != false).Sum(z => z.Values * (Testing2(elementID, z.ColorId))),
                        IsActive = y.IsActive
                    }).Where(x => x.IsActive != false).ToList(),
                    TotalPattern = x.Patterns.Count(),
                }).ToList();


                var recQuantity = await _unitOfWork.ElementQuantityRepository.GetAllAsync();
                foreach (var item in recQuantity)
                {
                    item.Element = null;
                }

                


                response.Data = new { Variety = test, RecQuantity = recQuantity.Where(x => x.ElementId == elementID), Element = element.Element1 };


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
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return BadRequest(response);
            }
            
        }

        private double TotalPoint(ICollection<PatternColor> patternColors)
        {
            double total = 0;

            foreach (var item in patternColors)
            {
                if(item.IsActive != false)
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
                return _defaultPoint;
            }
            //(await _unitOfWork.ElementQuantityRepository.GetAllAsync()).Where(x => x.ElementId == elementID && x.Quantity == patterns.Count()).ToList();
        }

        private double Testing3(int elementID ,int count)
        {
            try
            {

                var test = (_unitOfWork.ElementQuantityRepository.GetAll()).Where(x => x.ElementId == elementID && x.Quantity%10 == count%10).FirstOrDefault();

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
                if (test != null)
                    return 1;
                else
                    return -1;
            }
            catch (Exception)
            {
                return -1;
            }
            //(await _unitOfWork.ElementQuantityRepository.GetAllAsync()).Where(x => x.ElementId == elementID && x.Quantity == patterns.Count()).ToList();
        }


        [HttpPost("Pointing")]
        public async Task<ActionResult<Element>> Pointing([FromQuery] DateTime birthday, [FromQuery] string gender, int shapeId, int dirId, List<PointingModel> request)
        {
            BaseResponseModel response = new BaseResponseModel();
            try
            {
                int totalAmount = 0;
                foreach (var item in request)
                {
                    totalAmount += item.Quantity;
                }

                var elementId = _fengShuiService.CalculateFengShui(birthday, gender);
                var kuaId = _fengShuiService.CalculateCungPhi(birthday, gender);
                if (kuaId == 5)
                {
                    kuaId = gender.ToLower() == "male" ? 2 : 8;
                }
                var element = await _unitOfWork.ElementRepository.GetByIdAsync(elementId);
                if (element == null)
                {
                    response.Status = false;
                    response.Message = "Cannot calculate your element!";
                    return NotFound(Response);
                }
                await _unitOfWork.GeneralRepository.CreateAsync(new General
                {
                    ElementId = elementId,
                    KuaId = kuaId,
                    CreatedDate = DateTime.Now
                });

                var elementColor = (await _unitOfWork.ElementColorRepository.GetAllAsync()).Where(x => x.IsActive != false);
                foreach (var n in elementColor)
                {
                    n.Element = null;
                }
                


                //Pond Pointing

                var bonusPond = Testing(elementId, shapeId);

                var bonusDirection = Testing4(kuaId, dirId);


                //Koi Pointing


                List<Pattern> patterns = new List<Pattern>();
                foreach (var item in request)
                {
                    var pattern = (await _unitOfWork.PatternRepository.GetByIdAsync(item.PatternId));
                    if (pattern.IsActive != false)
                        patterns.Add(pattern);
                    else
                    {
                        response.Status = false;
                        response.Message = "Invalid Patterns does not found";
                        return NotFound(response);
                    }
                }
                var patternColor = (await _unitOfWork.PatternColorRepository.GetAllAsync()).Where(x => x.IsActive != false);

                var bonusQuantity = Testing3(elementId, totalAmount);

                var test = patterns.Select(x => new PatternResponseModel
                {
                    VarietyId = x.VarietyId,
                    PatternId = x.PatternId,
                    PatternName = x.PatternName,
                    ImageUrl = x.ImageUrl,
                    PatternColors = x.PatternColors.Where(y => y.IsActive != false).Select(z => new PatternColorResponseModel
                    {
                        ColorId = z.ColorId,
                        PatternId = z.PatternId,
                        PcolorId = z.PcolorId,
                        Values = z.Values,
                        ColorName = _unitOfWork.ColorRepository.GetById(z.ColorId).Name + $"({z.Values*100}%)",
                        IsActive = z.IsActive,
                        ComputeValues = (z.Values * Testing2(elementId, z.ColorId)),
                    }).Where(x => x.IsActive != false).ToList(),
                    IsActive = x.IsActive,
                    PatternPoint = Math.Round(x.PatternColors.Where(y => y.IsActive != false).Sum(z => z.Values * Testing2(elementId, z.ColorId)), 2) + bonusQuantity + bonusPond + bonusDirection,
                    Description = $"Default Value: {_defaultPoint}, " +
                    $"Koi's Values: {Math.Round(x.PatternColors.Where(y => y.IsActive != false).Sum(z => z.Values * Testing2(elementId, z.ColorId)) - _defaultPoint, 2)}, " +
                    $"Bonus on Quantity: {bonusQuantity}, " +
                    $"Bonus on Pond: {bonusPond}, " +
                    $"Bonus on Direction: {bonusDirection}"
                }).Where(x => x.IsActive != false).ToList();

                double total = 0;
                foreach (var pattern in test)
                {
                    total += pattern.PatternPoint;
                }


                element.Ponds = null;
                element.ElementQuantities = null;
                element.Generals = null;

                var color = await _unitOfWork.ColorRepository.GetAllAsync();
                foreach (var item in color)
                {
                    item.ElementColors = null;
                    item.PatternColors = null;
                }

                var direction = await _unitOfWork.DirectionRepository.GetAllAsync();
                foreach(var item in direction)
                {
                    item.Auspicious = null;
                    item.Inauspicious = null;
                }
                var auspicious = await _unitOfWork.AuspiciousRepository.GetAllAsync();
                var kuaAuspicious = auspicious.Where(x => x.KuaId == kuaId).ToList();
                var recDir = kuaAuspicious.Select(x => x.Direction).ToList().Select(x => x.DirectionName).ToList();

                var selectDir = (await _unitOfWork.DirectionRepository.GetByIdAsync(dirId)).DirectionName;

                var TotalPoint = total / test.Count;

                String Comments = getComments(TotalPoint);

                var shape = (await _unitOfWork.ShapeRepository.GetByIdAsync(shapeId)).Shape1;

                response.Status = true;
                response.Message = "Success";
                response.Data = new { Element = element, Shape = shape, Direction = selectDir, RecDir = recDir, KoiPoint = test , TotalPoint = TotalPoint, TotalAmount = totalAmount, Comment = Comments , bonusQuantity = bonusQuantity, bonusPond = bonusPond , bonusDirection = bonusDirection , defaultValues = _defaultPoint};
                return Ok(response);
            }
            catch (Exception ex)
            {
                response.Status = false;
                response.Message = ex.ToString();
                return BadRequest(response);
            }

        }

        private string getComments(double totalPoint)
        {
            if (totalPoint > 8 && totalPoint <= 10)
                return "Môi trường sống phản ánh sự hòa hợp tự nhiên, nơi dòng chảy năng lượng được lưu thông một cách thông suốt, tạo cảm giác bình an và thịnh vượng vượt bậc.";
            else if (totalPoint > 5 && totalPoint <= 8)
                return "Môi trường sống cân đối, ổn định nhưng đôi chỗ năng lượng có thể chưa thực sự lưu thông hoàn hảo, đòi hỏi thêm sự tinh tế trong việc cân bằng các yếu tố.";
            else if (totalPoint > 3 && totalPoint <= 5)
                return "Tổng thể không gian sống còn nhiều điểm cần khắc phục để đạt được sự hài hòa phong thủy, có những chỗ năng lượng bị ứ đọng hoặc không thông suốt, ảnh hưởng đến chất lượng cuộc sống.";
            else if (totalPoint >= 0 && totalPoint <= 3)
                return "Môi trường sống tạo ra cảm giác ngột ngạt, nơi năng lượng bị chặn đứng hoặc phát tán một cách tiêu cực, khiến cho chủ nhân dễ gặp căng thẳng, mệt mỏi và đối diện với những thử thách không đáng có.";
            else
                return "Somehow total Point is out of range.";
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



                var variety = (await _unitOfWork.VarietyRepository.GetAllAsync()).Where(x => x.IsActive != false);
                var pattern = (await _unitOfWork.PatternRepository.GetAllAsync()).Where(x => x.IsActive != false);
                //foreach (var item in pattern)
                //{
                //    item.Variety = null;
                //}
                var patternColor = await _unitOfWork.PatternColorRepository.GetAllAsync();
                //foreach(var item in patternColor)
                //{
                //    item.Pattern = null;
                //}
                var color = await _unitOfWork.ColorRepository.GetAllAsync();
                //foreach (var item in color)
                //{
                //    item.PatternColors = null;
                //    item.ElementColors = null;
                //}

                response.Data = variety.Select(x => new VarietyResponseModel
                {
                    VarietyId = x.VarietyId,
                    VarietyName = x.VarietyName,
                    ImageUrl = x.ImageUrl,
                    Patterns = x.Patterns.Select(y => new PatternResponseModel
                    {
                        PatternId = y.PatternId,
                        PatternName = y.PatternName,
                        ImageUrl = y.ImageUrl,
                        VarietyId = y.VarietyId,
                        IsActive = y.IsActive,
                        PatternColors = y.PatternColors.Select(z => new PatternColorResponseModel
                        {
                            ColorId = z.ColorId,
                            PatternId = z.PatternId,
                            PcolorId = z.PcolorId,
                            ColorName = _unitOfWork.ColorRepository.GetById(z.ColorId).Name,
                            IsActive = z.IsActive,
                        }).Where( x => x.IsActive != false).ToList(),
                    }).Where( x => x.IsActive != false).ToList(),
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

        [HttpGet("TotalAction")]
        public async Task<ActionResult<Variety>> TotalAction()
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";

                var dir = (await _unitOfWork.GeneralRepository.GetAllAsync()).Where(x => x.KuaId != null && x.ElementId == null).Count();
                var koi = (await _unitOfWork.GeneralRepository.GetAllAsync()).Where(x => x.KuaId == null && x.ElementId != null).Count();
                var pointing = (await _unitOfWork.GeneralRepository.GetAllAsync()).Where(x => x.KuaId != null && x.ElementId != null).Count();

                response.Data = new { TotalDirection = dir, TotalKoi = koi, TotalPointing = pointing, Total = dir + koi + pointing };

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
