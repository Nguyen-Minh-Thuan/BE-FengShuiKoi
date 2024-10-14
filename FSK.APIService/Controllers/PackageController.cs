using FSK.APIService.ResponseModel;
using FSK.APIService.RequestModel;
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

        [HttpPut("UpdatePackage/{id}")]
        public async Task<ActionResult<Package>> UpdatePackage(int id, UpdatePackageRequestModel updatedPackage)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var existingPackage = await _unitOfWork.PackageRepository.GetByIdAsync(id);
                if (existingPackage == null)
                {
                    response.Status = false;
                    response.Message = "Package not found";
                    return NotFound(response);
                }

                // Update properties only if they are provided in the request
                if (!string.IsNullOrEmpty(updatedPackage.PackageName))
                {
                    existingPackage.PackageName = updatedPackage.PackageName;
                }

                if (updatedPackage.Duration != 0)
                {
                    existingPackage.Duration = updatedPackage.Duration;
                }

                if (updatedPackage.Price != null)
                {
                    existingPackage.Price = updatedPackage.Price;
                }

                await _unitOfWork.PackageRepository.UpdateAsync(existingPackage);
                await _unitOfWork.SaveChangesAsync();

                response.Status = true;
                response.Message = "Package updated successfully";
                response.Data = existingPackage;
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
