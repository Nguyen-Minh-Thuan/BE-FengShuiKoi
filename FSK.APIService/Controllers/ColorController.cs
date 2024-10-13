using FSK.APIService.ResponseModel;
using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ColorController : ControllerBase
    {

        private readonly UnitOfWork _unitOfWork;

        public ColorController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;

        [HttpGet("GetColor")]
        public async Task<ActionResult<IEnumerable<Element>>> GetColor()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.ColorRepository.GetAllAsync();
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
