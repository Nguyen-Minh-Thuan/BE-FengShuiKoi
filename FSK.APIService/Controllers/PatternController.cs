using FSK.APIService.RequestModel;
using FSK.APIService.ResponseModel;
using FSK.Repository.Models;
using FSK.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using Microsoft.IdentityModel.Tokens;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PatternController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;

        public PatternController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;

        [HttpGet("GetAll")]
        public async Task<ActionResult<Pattern>> GetAll()
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                response.Data = (await _unitOfWork.PatternRepository.GetAllAsync()).Where(x => x.IsActive != false);
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.ToString();
                return BadRequest(response);
            }

        }

        [HttpGet("GetByPage")]
        public async Task<ActionResult<IEnumerable<Pattern>>> GetPageVar(int pageIndex = 0, int pageSize = 10)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                response.Data = (await _unitOfWork.PatternRepository.GetPageAsync(pageIndex, pageSize)).Where(x => x.IsActive != false);
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
        public async Task<ActionResult<IEnumerable<Pattern>>> GetById(int id)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                
                var output = await _unitOfWork.PatternRepository.GetByIdAsync(id);
                if (output == null)
                {
                    response.Status = false;
                    response.Message = "Pattern not found";
                    return NotFound(response);
                }
                if (output.IsActive == false)
                {
                    response.Status = false;
                    response.Message = "Pattern not found";
                    return NotFound(response);
                }
                var Pcolor = await _unitOfWork.PatternColorRepository.GetAllAsync();
                foreach (var item in Pcolor)
                {
                    item.Pattern = null;
                }
                var color = await _unitOfWork.ColorRepository.GetAllAsync();
                foreach (var item in color)
                {
                    item.ElementColors = null;
                    item.PatternColors = null;
                }


                response.Status = true;
                response.Message = "Success";
                response.Data = output;
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
        public async Task<ActionResult<IEnumerable<Pattern>>> CreatePattern(PatternRequestModel model)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var Variety = await _unitOfWork.VarietyRepository.GetByIdAsync(model.VarietyId);
                if (Variety == null)
                {
                    response.Status = false;
                    response.Message = "Variety not found";
                    return NotFound(response);
                }
                if (Variety.IsActive == false)
                {
                    response.Status = false;
                    response.Message = "Variety not found";
                    return NotFound(response);
                }
                if (model.PatternName.IsNullOrEmpty())
                {
                    response.Status = false;
                    response.Message = "Pattern Name not null!";
                    return BadRequest(response);
                }
                if (model.ImageUrl.IsNullOrEmpty())
                {
                    response.Status = false;
                    response.Message = "There must be an Image!!";
                    return BadRequest(response);
                }

                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.PatternRepository.CreateAsync(new Pattern
                {
                    VarietyId = model.VarietyId,
                    ImageUrl = model.ImageUrl,
                    IsActive = true,
                    PatternName = model.PatternName
                });
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }


        }

        [HttpPut("Update/{id}")]
        public async Task<ActionResult<IEnumerable<Pattern>>> UpdateVar(int id, PatternRequestModel model)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {

                var total = (await _unitOfWork.PatternRepository.GetAllAsync()).Count();
                if (id < 0 || id > total)
                {
                    response.Status = false;
                    response.Message = "Pattern not found";
                    return NotFound(response);
                }
                    
                var pattern = await _unitOfWork.PatternRepository.GetByIdAsync(id);
                if (pattern.IsActive == false)
                {
                    response.Status = false;
                    response.Message = "Pattern not found";
                    return NotFound(response);
                }

                var totalVariety = (await _unitOfWork.VarietyRepository.GetAllAsync()).Count();

                if (model.VarietyId < 0 || model.VarietyId > totalVariety)
                {
                    response.Status = false;
                    response.Message = "Variety not found!";
                    return NotFound(response);
                }
                var Variety = await _unitOfWork.VarietyRepository.GetByIdAsync(model.VarietyId);
                if (Variety.IsActive == false)
                {
                    response.Status = false;
                    response.Message = "Variety not found!";
                    return NotFound(response);
                }
                pattern.VarietyId = model.VarietyId;


                if (!model.PatternName.IsNullOrEmpty())
                    pattern.PatternName = model.PatternName;
                if (!model.ImageUrl.IsNullOrEmpty())
                    pattern.ImageUrl = model.ImageUrl;

                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.PatternRepository.UpdateAsync(pattern);
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return StatusCode(500, response);
            }


        }

        [HttpDelete("Detele/{id}")]
        public async Task<ActionResult<IEnumerable<Pattern>>> DeletePattern(int id)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var total = (await _unitOfWork.PatternRepository.GetAllAsync()).Count();
                if (0 > id || id > total)
                {
                    response.Status = false;
                    response.Message = "Pattern not found";
                    return NotFound(response);
                }

                var pattern = await _unitOfWork.PatternRepository.GetByIdAsync(id);
                if(pattern.IsActive == false)
                {
                    response.Status = false;
                    response.Message = "Pattern not found";
                    return NotFound(response);
                }

                pattern.IsActive = false;

                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.PatternRepository.UpdateAsync(pattern);
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }


        }

    }
}
