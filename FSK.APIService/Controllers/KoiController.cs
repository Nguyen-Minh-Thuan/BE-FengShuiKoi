using FSK.APIService.RequestModel;
using FSK.APIService.ResponseModel;
using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KoiController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;

        public KoiController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;

        /// <summary>
        /// Get Koi varieties (in divided pages)
        /// </summary>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize">Size of the page</param>
        /// <returns>A list of Koi varieties divided by page</returns>
        /// <response code="200">Returns the list contains all Koi varieties (divided in page)</response>
        [HttpGet("KoiByPage")]
        public async Task<ActionResult<IEnumerable<Variety>>> GetPageKois(int pageIndex = 0, int pageSize = 10)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var varieties = (await _unitOfWork.VarietyRepository.GetPageAsync(pageIndex, pageSize)).Where(x => x.IsActive != false);
                var patterns = (await _unitOfWork.PatternRepository.GetAllAsync()).Where(x => x.IsActive != false);
                response.Data = varieties;

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
        /// Get every Koi varieties
        /// </summary>
        /// <returns>A list of all Koi varieties</returns>
        /// <response code="200">Returns the list contains all Koi varieties</response>
        [HttpGet("GetAllKois")]
        public async Task<ActionResult<IEnumerable<Variety>>> GetAllKois()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var varieties = (await _unitOfWork.VarietyRepository.GetAllAsync()).Where(x => x.IsActive != false);

                foreach (var variety in varieties)
                {
                    variety.Patterns = (await _unitOfWork.PatternRepository.GetAllAsync()).Where(x => x.IsActive != false && x.VarietyId == variety.VarietyId).ToList();
                }
                response.Data = varieties.Where(x => x.IsActive != false);
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
        /// Get a Koi variety by its id
        /// </summary>
        /// <param name="id">The id of the Koi variety needed to show</param>
        /// <returns>The Koi variety of that id</returns>
        /// <response code="200">Returns the Koi variety</response>
        [HttpGet("GetKoiById/{id}")]
        public async Task<ActionResult<Variety>> GetKoiById(int id)
        {
            BaseResponseModel response = new BaseResponseModel();

            
            var variety = await _unitOfWork.VarietyRepository.GetByIdAsync(id);
            if (variety == null)
            {
                response.Status = false;
                response.Message = "Koi variety not found";
                return NotFound(response);
            }
            if (variety.IsActive == false)
            {
                response.Status = false;
                response.Message = "Koi variety not found";
                return NotFound(response);
            }

            variety.Patterns = (await _unitOfWork.PatternRepository.GetAllAsync()).Where(x => x.IsActive != false && x.VarietyId == variety.VarietyId).ToList();
            //foreach (var p in patterns)
            //{
            //    p.Variety = null;
            //}
            //variety.Patterns = patterns;

            response.Status = true;
            response.Message = "Success";
            response.Data = variety;

            

            return Ok(response);
        }

        /// <summary>
        /// Add a new Koi variety
        /// </summary>
        /// <param name="model"></param>
        /// <returns>Returns the newly created Koi variety</returns>
        /// <param cref="KoiVarietyRequestModel" name="KoiVarietyRequestModel">Create Koi variety Request Model</param>
        /// <remarks>
        /// Sample request:
        ///
        ///     POST /api/Koi/AddNewKoi
        ///     {
        ///        "varietyName": "K001",
        ///        "imageUrl": "None",
        ///        "description": "This is example description"
        ///     }
        /// </remarks>
        /// <response code="200" cref="KoiVarietyRequestModel">Returns the newly created Koi variety</response>
        [Authorize(Policy = "Admin")]
        [HttpPost("AddNewKoi")]
        public async Task<IActionResult> CreateNewKoi([FromBody] KoiVarietyRequestModel model)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {

                if (model.ImageUrl.IsNullOrEmpty())
                {
                    response.Status = false;
                    response.Message = "There must be an Image!";
                    return BadRequest(response);
                }
                if (model.Description.IsNullOrEmpty())
                {
                    response.Status = false;
                    response.Message = "There must be an Description!";
                    return BadRequest(response);
                }
                if (model.VarietyName.IsNullOrEmpty())
                {
                    response.Status = false;
                    response.Message = "There must be an Name!";
                    return BadRequest(response);
                }

                var existingKoi = await _unitOfWork.VarietyRepository.GetAllAsync();
                var koiExists = existingKoi.Any(k => k.VarietyName.Equals(model.VarietyName, StringComparison.OrdinalIgnoreCase));

                // Check if a Koi with the same name already exists
                if (koiExists)
                {
                    response.Status = false;
                    response.Message = "A Koi with this name already exists";
                    return BadRequest(response);
                }


                var variety = new Variety
                {
                    VarietyName = model.VarietyName,
                    Description = model.Description,
                    ImageUrl = model.ImageUrl,
                    IsActive = true
                };

                await _unitOfWork.VarietyRepository.CreateAsync(variety);

                response.Status = true;
                response.Message = "Successfully added new Koi";
                response.Data = variety;
                return Ok(response);
            }
            catch (Exception)
            {
                response.Status = false;
                response.Message = "An error occurred while adding a new koi variety";
                return StatusCode(500, response);
            }
        }

        /// <summary>
        /// Update information of an existed Koi variety
        /// </summary>
        /// <param name="id">Id of the variety</param>
        /// <param name="model">Information needed to update</param>
        /// <returns>The updated information of the Koi variety</returns>
        /// <response code="200" cref="KoiVarietyRequestModel">Returns the updated Koi variety</response>
        [Authorize(Policy = "Admin")]
        [HttpPut("UpdateKoi/{id}")]
        public async Task<IActionResult> UpdateKoi(int id, [FromBody] KoiVarietyRequestModel model)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                if (model == null)
                {
                    response.Status = false;
                    response.Message = "Invalid request data";
                    return BadRequest(response);
                }
                var Variety = await _unitOfWork.VarietyRepository.GetByIdAsync(id);
                if (Variety == null)
                {
                    response.Status = false;
                    response.Message = "Koi variety not found";
                    return NotFound(response);
                }
                if (Variety.IsActive == false)
                {
                    response.Status = false;
                    response.Message = "Koi variety not found";
                    return NotFound(response);
                }




                // Check if the VarietyName is unique (excluding the current variety)
                var existingVarieties = await _unitOfWork.VarietyRepository.GetAllAsync();
                var duplicateVariety = existingVarieties.FirstOrDefault(v => v.VarietyName.Equals(model.VarietyName, StringComparison.OrdinalIgnoreCase) && v.VarietyId != id);
                if (duplicateVariety != null)
                {
                    response.Status = false;
                    response.Message = "A Koi variety with this name already exists";
                    return BadRequest(response);
                }

                // Update fields
                if (!model.VarietyName.IsNullOrEmpty()) Variety.VarietyName = model.VarietyName;
                if (!model.Description.IsNullOrEmpty()) Variety.Description = model.Description;
                if (!model.ImageUrl.IsNullOrEmpty()) Variety.ImageUrl = model.ImageUrl;

                await _unitOfWork.VarietyRepository.UpdateAsync(Variety);
                await _unitOfWork.SaveChangesAsync();

                response.Status = true;
                response.Message = "Koi variety updated successfully";
                response.Data = Variety;
                return Ok(response);
            }
            catch (Exception)
            {
                response.Status = false;
                response.Message = "An error occurred while updating the koi variety";
                return BadRequest(response);
            }
        }


        //Note to adjust this to not really "delete"
        /// <summary>
        /// Delete a Koi variety by its ID
        /// </summary>
        /// <param name="id">The ID of the Koi variety to delete</param>
        /// <returns>A response indicating the result of the delete operation</returns>
        /// <response code="200">Returns a success message if the Koi variety was deleted</response>
        /// <response code="400">If there was an error during the delete operation</response>   
        [Authorize(Policy = "Admin")]
        [HttpDelete("DeleteKoi/{id}")]
        public async Task<IActionResult> DeleteKoi(int id)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {

                

                var Variety = await _unitOfWork.VarietyRepository.GetByIdAsync(id);
                if (Variety == null)
                {
                    response.Status = false;
                    response.Message = "Koi variety not found";
                    return NotFound(response);
                }
                if (Variety.IsActive == false)
                {
                    response.Status = false;
                    response.Message = "Koi variety not found";
                    return NotFound(response);
                }
                Variety.IsActive = false;



                await _unitOfWork.VarietyRepository.UpdateAsync(Variety);

                response.Status = true;
                response.Message = "Koi variety deleted successfully";
                return Ok(response);
            }
            catch (Exception)
            {
                response.Status = false;
                response.Message = "An error occurred while deleting the Koi variety";
                return StatusCode(500, response);
            }
        }
    }
}
