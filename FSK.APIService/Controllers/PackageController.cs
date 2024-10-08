using FSK.APIService.RespondModel;
using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PackageController : ControllerBase
    {

        private readonly UnitOfWork _unitOfWork;

        public PackageController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;

        [HttpGet("GetPackage")]
        public async Task<ActionResult<IEnumerable<Package>>> GetPackage()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.PackageRepository.GetAllAsync();
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
