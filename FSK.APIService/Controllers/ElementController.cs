using FSK.APIService.ResponseModel;
using FSK.Repository.Models;
using FSK.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ElementController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;

        public ElementController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;

        [HttpGet("GetElement")]
        public async Task<ActionResult<IEnumerable<Element>>> GetElement()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.ElementRepository.GetAllAsync();
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
