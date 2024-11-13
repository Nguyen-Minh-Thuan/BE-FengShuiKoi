using FSK.APIService.RequestModel;
using FSK.APIService.ResponseModel;
using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VariertyController : ControllerBase
    {

        private readonly UnitOfWork _unitOfWork;

        public VariertyController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;

        [HttpGet("GetAll")]
        public async Task<ActionResult<Variety>> GetAll()
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";

                response.Data = (await _unitOfWork.VarietyRepository.GetAllAsync()).Except(_unitOfWork.VarietyRepository.GetAll().Where(x => x.IsActive != false));
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
        public async Task<ActionResult<IEnumerable<Variety>>> GetPageVar(int pageIndex = 0, int pageSize = 10)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var output = (await _unitOfWork.VarietyRepository.GetPageAsync(pageIndex, pageSize)).Except(_unitOfWork.VarietyRepository.GetAll().Where(x => x.IsActive == false));
                if (output.IsNullOrEmpty())
                    return BadRequest("There is no values to return!");
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

        [HttpGet("GetById/{id}")]
        public async Task<ActionResult<IEnumerable<Variety>>> GetById(int id)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var totalVar = (await _unitOfWork.VarietyRepository.GetAllAsync()).Count();
                if (id < 0 || id > totalVar)
                    return BadRequest("ID not found");
                var output = await _unitOfWork.VarietyRepository.GetByIdAsync(id);
                if (output.IsActive == false)
                    return BadRequest("ID not found");
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
        public async Task<ActionResult<IEnumerable<Variety>>> CreateVar(KoiVarietyRequestModel var)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                if (var.ImageUrl.IsNullOrEmpty())
                {
                    response.Status = false;
                    response.Message = "There must be an Image!";
                    return BadRequest(response);
                }
                if (var.Description.IsNullOrEmpty())
                {
                    response.Status = false;
                    response.Message = "There must be an Description!";
                    return BadRequest(response);
                }
                if (var.VarietyName.IsNullOrEmpty())
                {
                    response.Status = false;
                    response.Message = "There must be an Name!";
                    return BadRequest(response);
                }
                response.Data = await _unitOfWork.VarietyRepository.CreateAsync(
                    new Variety { VarietyName = var.VarietyName,
                                Description = var.Description,
                                ImageUrl = var.ImageUrl,
                                IsActive = true
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
        public async Task<ActionResult<IEnumerable<Variety>>> UpdateVar(int id,KoiVarietyRequestModel var)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var total = (await _unitOfWork.VarietyRepository.GetAllAsync()).Count();
                if (0 > id || id > total)
                    return BadRequest("This variety is not available!");
                var Variety = await _unitOfWork.VarietyRepository.GetByIdAsync(id);
                if (Variety.IsActive == false)
                    return BadRequest("This variety is not available!");

                if (!var.VarietyName.IsNullOrEmpty()) Variety.VarietyName = var.VarietyName;
                if (!var.Description.IsNullOrEmpty()) Variety.Description = var.Description;
                if (!var.ImageUrl.IsNullOrEmpty()) Variety.ImageUrl = var.ImageUrl;

                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.VarietyRepository.UpdateAsync(Variety);
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }


        }

        [HttpDelete("Detele/{id}")]
        public async Task<ActionResult<IEnumerable<Variety>>> DeleteVar(int id)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var total = (await _unitOfWork.VarietyRepository.GetAllAsync()).Count();
                if (0 > id || id > total)
                {
                    response.Status = false;
                    response.Message = "This variety not available!";
                    return NotFound(response);
                }

                var Variety = await _unitOfWork.VarietyRepository.GetByIdAsync(id);
                if (Variety.IsActive == false)
                {
                    response.Status = false;
                    response.Message = "This variety not available!";
                    return NotFound(response);
                }
                Variety.IsActive = false;

                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.VarietyRepository.UpdateAsync(Variety);
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
