using FSK.APIService.ResponseModel;
using FSK.APIService.RequestModel;
using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PackageController : ControllerBase
    {

        private readonly UnitOfWork _unitOfWork;

        public PackageController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;

        /// <summary>
        /// Get every packages
        /// </summary>
        /// <returns>A list of all packages</returns>
        /// <response code="200">Returns the list contains all packages</response>
        [HttpGet("GetAllPackages")]
        public async Task<ActionResult<IEnumerable<Package>>> GetAllPackages()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                response.Data = (await _unitOfWork.PackageRepository.GetAllAsync()).Where(x => x.IsActive != false);
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }

        /// <summary>
        /// Get a package by its id
        /// </summary>
        /// <param name="id">The id of the package needed to show</param>
        /// <returns>The package of that id</returns>
        /// <response code="200">Returns the package</response>
        /// <response code="400">If the package with the specified ID is not found</response>
        [HttpGet("GetPackageById/{id}")]
        public async Task<ActionResult<Package>> GetPackageById(int id)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var package = await _unitOfWork.PackageRepository.GetByIdAsync(id);

                if (package == null)
                {
                    response.Status = false;
                    response.Message = "Package not found";
                    return BadRequest(response);
                }
                if (package.IsActive == false)
                {
                    response.Status = false;
                    response.Message = "Package not found";
                    return BadRequest(response);
                }

                response.Status = true;
                response.Message = "Success";
                response.Data = package;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = true;
                response.Message = $"{err.ToString()}";
                return BadRequest(response);

            }
        }

        /// <summary>
        /// Add a new package
        /// </summary>
        /// <param name="model"></param>
        /// <returns>Returns the newly created package</returns>
        /// <param cref="PackageRequestModel" name="PackageRequestModel">Create Package Request Model</param>
        /// <remarks>
        /// Sample request:
        ///
        ///     POST /api/Package/AddNewPackage
        ///     {
        ///        "packageName": "The most vippro package",
        ///        "price": "69420",
        ///        "duration": "10"
        ///     }
        /// </remarks>
        /// <response code="200" cref="PackageRequestModel">Returns the newly created package</response>
        /// <response code="400">If the package's name already existed</response>
        [Authorize(Policy = "Admin")]
        [HttpPost("AddNewPackage")]
        public async Task<IActionResult> CreateNewPackage([FromBody] PackageRequestModel model)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                var existingPackage = await _unitOfWork.PackageRepository.GetAllAsync();
                var packageExists = existingPackage.Any(k => k.PackageName.Equals(model.PackageName, StringComparison.OrdinalIgnoreCase));

                // Check if a package with the same name already exists
                if (packageExists)
                {
                    response.Status = false;
                    response.Message = "A package with this name already exists";
                    return BadRequest(response);
                }


                var package = new Package
                {
                    PackageName = model.PackageName,
                    Price = model.Price,
                    Duration = model.Duration,
                    
                    IsActive = true,
                };

                await _unitOfWork.PackageRepository.CreateAsync(package);
                await _unitOfWork.SaveChangesAsync();

                response.Status = true;
                response.Message = "Successfully added new package";
                response.Data = package;
                return Ok(response);
            }
            catch (Exception)
            {
                response.Status = false;
                response.Message = "An error occurred while adding a new package";
                return StatusCode(500, response);
            }
        }

        /// <summary>
        /// Update information of an existed package
        /// </summary>
        /// <param name="id">Id of the package</param>
        /// <param name="updatedPackage">Information needed to update</param>
        /// <returns>The updated information of the package</returns>
        /// <response code="200" cref="KoiVarietyRequestModel">Returns the updated package</response>
        [Authorize(Policy = "Admin")]
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

        /// <summary>
        /// Delete a package by its ID
        /// </summary>
        /// <param name="id">The ID of the package to delete</param>
        /// <returns>A response indicating the result of the delete operation</returns>
        /// <response code="200">Returns a success message if the package was deleted</response>
        /// <response code="500">If there was an error during the delete operation</response>
        [Authorize(Policy = "Admin")]
        [HttpDelete("DeletePackage/{id}")]
        public async Task<IActionResult> DeletePackage(int id)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                if (id <= 0)
                {
                    response.Status = false;
                    response.Message = "Invalid package id";
                    return BadRequest(response);
                }

                var package = await _unitOfWork.PackageRepository.GetByIdAsync(id);

                if (package == null)
                {
                    response.Status = false;
                    response.Message = "Package not found";
                    return NotFound(response);
                }

                package.IsActive = false;
                await _unitOfWork.PackageRepository.UpdateAsync(package);

                response.Status = true;
                response.Message = "Package deleted successfully";
                return Ok(response);
            }
            catch (Exception)
            {
                response.Status = false;
                response.Message = "An error occurred while deleting the package";
                return StatusCode(500, response);
            }
        }

    }
}
