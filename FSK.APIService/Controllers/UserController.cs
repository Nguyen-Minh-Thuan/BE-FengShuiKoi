using FSK.Repository;
using FSK.Repository.Models;
using FSK.APIService.RespondModel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FSK.APIService.RequestModel;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;

        public UserController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;

        [HttpGet]
        public async Task<ActionResult<IEnumerable<User>>> GetPageUser(int pageIndex = 0, int pageSize = 10)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                response.Data = await _unitOfWork.UserRepository.GetPageAsync(pageIndex,pageSize);
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }


        }

        [HttpGet("{id}")]
        public async Task<ActionResult<User>> GetUser(int id)
        {
            BaseResponseModel response = new BaseResponseModel();

            response.Status = true;
            response.Message = "Success";
            var user = await _unitOfWork.UserRepository.GetByIdAsync(id);
            var role = await _unitOfWork.RoleRepository.GetAllAsync();
            foreach (var item in role)
            {
                item.Users = null;
            }
            response.Data = user;

            if (response.Data == null)
            {
                response.Status = false;
                response.Message = "User not found";
                return BadRequest(response);
            }

            return Ok(response);
        }


        // PUT: api/Products/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("UpdateRole/{id}")]
        public async Task<IActionResult> UpdateUserRole(int id, int newRole)
        {
            var user = await _unitOfWork.UserRepository.GetByIdAsync(id);
            if (user == null)
            {
                return NotFound("User not found");
            }

            user.RoleId = newRole;

            try
            {
                await _unitOfWork.UserRepository.UpdateAsync(user);
                await _unitOfWork.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!await UserExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Ok("User role updated successfully");
        }

        private async Task<bool> UserExists(int id)
        {
            return await _unitOfWork.UserRepository.GetByIdAsync(id) != null;
        }


        // DELETE: api/Products/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            var user = await _unitOfWork.UserRepository.GetByIdAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            await _unitOfWork.UserRepository.RemoveAsync(user);

            return NoContent();
        }

        [HttpPut("UpdateInfo/{id}")]
        public async Task<IActionResult> UpdateUserInfo(int id, string newName, string newBio, string newImageURL)
        {
            BaseResponseModel response = new BaseResponseModel();
            try
            {
                //Get user.
                var user = await _unitOfWork.UserRepository.GetByIdAsync(id);
                if (user == null)
                {
                    response.Status = false;
                    response.Message = "User not found";
                    return NotFound(response);
                }
                //Trying to save data.
                try
                {
                    user.UserName = newName;
                    user.Bio = newBio;
                    user.ImageUrl = newImageURL;
                    await _unitOfWork.UserRepository.UpdateAsync(user);
                    await _unitOfWork.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException db_err)
                {
                    if (!await UserExists(id))
                    {
                        response.Status = false;
                        response.Message = "User not found while inserting";
                        return NotFound(response);
                    }
                    else
                    {
                        response.Status = false;
                        response.Message = db_err.ToString();
                        return BadRequest(response);
                    }
                }
                response.Status = true;
                response.Message = "User role updated successfully";
                response.Data = user;
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
