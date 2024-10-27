using FSK.APIService.RequestModel;
using FSK.APIService.ResponseModel;
using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.Collections.Generic;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PatternColorController : ControllerBase
    {

        private readonly UnitOfWork _unitOfWork;

        public PatternColorController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;


        [HttpGet("GetByPage")]
        public async Task<ActionResult<IEnumerable<PatternColor>>> GetPage(int pageIndex = 0, int pageSize = 10)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var models = (await _unitOfWork.PatternColorRepository.GetPageAsync(pageIndex, pageSize)).Where(x => x.IsActive != false);
                if (models.Count() == 0)
                {
                    response.Status = false;
                    response.Message = "There is no item to return!";
                    return NotFound(response);  
                }
                response.Data = models;
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
        public async Task<ActionResult<IEnumerable<PatternColor>>> GetAll()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var models = (await _unitOfWork.PatternColorRepository.GetAllAsync()).Where(x => x.IsActive != false);
                if (models.Count() == 0)
                {
                    response.Status = false;
                    response.Message = "There is no item to return!";
                    return NotFound(response);
                }
                response.Data = models;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }
        }

        [HttpGet("GetById/{id}")]
        public async Task<ActionResult<PatternColor>> GetById(int id)
        {
            BaseResponseModel response = new BaseResponseModel();

            var pattern = await _unitOfWork.PatternColorRepository.GetByIdAsync(id);
            if (pattern == null)
            {
                response.Status = false;
                response.Message = "Koi Pattern color not found";
                return NotFound(response);
            }
            if (pattern.IsActive == false)
            {
                response.Status = false;
                response.Message = "Koi Pattern color not found";
                return NotFound(response);
            }
            var color = await _unitOfWork.PatternColorRepository.GetAllAsync();
            foreach (var item in color)
            {
                item.Pattern = null;
                item.Color = null;
            }


            response.Status = true;
            response.Message = "Success";
            response.Data = pattern;

            return Ok(response);
        }

        [HttpPost("InputPatternColor")]
        public async Task<ActionResult<PatternColor>> InputColor(int id, List<PatternColorRequestModel> list)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                double totalValue = 0;

                var samePattern = (await _unitOfWork.PatternColorRepository.GetAllAsync()).Where(x => x.PatternId == id && x.IsActive != false);
                if (!samePattern.IsNullOrEmpty())
                    foreach (var item in samePattern)
                        totalValue += item.Values;

                foreach (var item in list)
                {
                    
                    if (_unitOfWork.ColorRepository.GetById(item.colorid) == null)
                    {
                        response.Status = false;
                        response.Message = "Invalid ColordID!";
                        response.Data = item;
                        return BadRequest(response);
                    }
                    if (item.value == 0)
                    {
                        response.Status = false;
                        response.Message = "Invalid Value!";
                        response.Data = item;
                        return BadRequest(response);
                    }
                    totalValue += item.value;
                }
                if (totalValue > 1 || totalValue <= 0)
                {
                    response.Status = false;
                    response.Message = "The total values of a pattern must be 1";
                    return BadRequest(response);
                }
                foreach (var item in list)
                {
                    await _unitOfWork.PatternColorRepository.CreateAsync(
                        new PatternColor 
                        { 
                        ColorId = item.colorid,
                        IsActive = true,
                        PatternId = id,
                        Values = item.value
                        });
                }

                response.Status = true;
                response.Message = "Success";
                response.Data = list.Count();
                return Ok(response);

            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return BadRequest(response);
            }
            
        }

        [HttpDelete("DeletePatternColor")]
        public async Task<ActionResult<PatternColor>> DeletePatternColor(int id)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var model = await _unitOfWork.PatternColorRepository.GetByIdAsync(id);
                if (model == null)
                {
                    response.Status = false;
                    response.Message = "PatternColor not found!";
                    return NotFound(response);
                }
                if (model.IsActive == false)
                {
                    response.Status = false;
                    response.Message = "PatternColor not found!";
                    return NotFound(response);
                }
                model.IsActive = false;

                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.PatternColorRepository.UpdateAsync(model);
                return Ok(response);

            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return BadRequest(response);
            }

        }

        [HttpPut("UpdatePatternColor")]
        public async Task<ActionResult<PatternColor>> UpdatePatternColor(int PatternId,int PatternColorId, PatternColorRequestModel model)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                double totalValue = 0;
                var update = await _unitOfWork.PatternColorRepository.GetByIdAsync(PatternColorId);
                if(update == null)
                {
                    response.Status = false;
                    response.Message = "PatternColor not found!";
                    return NotFound(response);
                }
                if (update.IsActive == false)
                {
                    response.Status = false;
                    response.Message = "PatternColor not found!";
                    return NotFound(response);
                }
                var samePattern = (await _unitOfWork.PatternColorRepository.GetAllAsync()).Where(x => x.PatternId == PatternId && x.IsActive != false);
                if (!samePattern.IsNullOrEmpty())
                    foreach (var item in samePattern)
                        totalValue += item.Values;

                totalValue -= update.Values;
                if (_unitOfWork.ColorRepository.GetById(model.colorid) == null)
                {
                    response.Status = false;
                    response.Message = "Invalid ColordID!";
                    response.Data = model;
                    return BadRequest(response);
                }
                if (model.value == 0)
                {
                    response.Status = false;
                    response.Message = "Invalid Value!";
                    response.Data = model;
                    return BadRequest(response);
                }
                totalValue += model.value;

                if (totalValue != 1)
                {
                    response.Status = false;
                    response.Message = "The total values of a pattern must be 1";
                    return BadRequest(response);
                }

                update.ColorId = model.colorid;
                update.Values = model.value;

                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.PatternColorRepository.UpdateAsync(update);
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
