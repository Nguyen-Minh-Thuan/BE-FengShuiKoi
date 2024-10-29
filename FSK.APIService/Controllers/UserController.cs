using FSK.Repository;
using FSK.Repository.Models;
using FSK.APIService.ResponseModel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FSK.APIService.RequestModel;
using Microsoft.AspNetCore.Identity;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;

        public UserController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;


        /// <summary>
        /// Get users (in divided pages)
        /// </summary>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize">Size of the page</param>
        /// <returns>A list of users divided by page</returns>
        /// <response code="200">Returns the list contains all users (divided in page)</response>
        [HttpGet("GetUserByPage")]
        public async Task<ActionResult<IEnumerable<User>>> GetPageUser(int pageIndex = 0, int pageSize = 10)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var output = (await _unitOfWork.UserRepository.GetPageAsync(pageIndex, pageSize)).Where(x => x.IsActive != null);
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



        /// <summary>
        /// Get an user by their id
        /// </summary>
        /// <param name="id">The id of the user needed to be shown</param>
        /// <returns>The user of that id</returns>
        /// <response code="200">Returns the user</response>
        [HttpGet("GetUserById")]
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
            

            if (user == null)
            {
                response.Status = false;
                response.Message = "User not found";
                return BadRequest(response);
            }
            user.Password = null;
            response.Data = user;
            return Ok(response);
        }


        /// <summary>
        /// Update information of an existed user
        /// </summary>
        /// <param name="id">Id of the user</param>
        /// <param name="newRole">New role to update</param>
        /// <returns>The updated information of the Koi variety</returns>
        /// <response code="200">Returns the updated user</response>
        [HttpPut("UpdateUserRole/{id}")]
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

        //Note to adjust this to not really "delete"
        // DELETE: api/Products/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            var user = await _unitOfWork.UserRepository.GetByIdAsync(id);
            if (user == null)
            {
                return NotFound();
            }
            user.IsActive = false;
            await _unitOfWork.UserRepository.UpdateAsync(user);

            return NoContent();
        }

        /// <summary>
        /// Update information of an existed user
        /// </summary>
        /// <param name="id">Id of the user</param>
        /// <param name="model">Information needed to update</param>
        /// <returns>The updated information of the user</returns>
        /// <response code="200" cref="UserRequestModel">Returns the updated user</response>
        [HttpPut("UpdateUser/{id}")]
        public async Task<IActionResult> UpdateUser(int id, [FromBody] UserRequestModel model)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                if (model == null || id <= 0)
                {
                    response.Status = false;
                    response.Message = "Invalid request data";
                    return BadRequest(response);
                }

                var user = await _unitOfWork.UserRepository.GetByIdAsync(id);

                if (user == null)
                {
                    response.Status = false;
                    response.Message = "User not found";
                    return NotFound(response);
                }

                bool hasChanges = false;

                // Update fields if they are provided and different from current values
                if (model.UserName != null && model.UserName != user.UserName)
                {
                    var existingName = await _unitOfWork.UserRepository.FirstOrDefaultAsync(u => u.UserName == model.UserName);
                    if (existingName != null)
                    {
                        response.Status = false;
                        response.Message = "Username already in use.";
                        return BadRequest(response);
                    }
                    user.UserName = model.UserName;
                    hasChanges = true;
                }
                if (model.Email != null && model.Email != user.Email)
                {
                    var existingEmail = await _unitOfWork.UserRepository.FirstOrDefaultAsync(u => u.Email == model.Email);
                    if (existingEmail != null)
                    {
                        response.Status = false;
                        response.Message = "Email already in use.";
                        return BadRequest(response);
                    }
                    user.Email = model.Email;
                    hasChanges = true;
                }
                if (model.Bio != null && model.Bio != user.Bio)
                {
                    user.Bio = model.Bio;
                    hasChanges = true;
                }
                if (model.ImageUrl != null && model.ImageUrl != user.ImageUrl)
                {
                    user.ImageUrl = model.ImageUrl;
                    hasChanges = true;
                }

                if (hasChanges)
                {
                    await _unitOfWork.UserRepository.UpdateAsync(user);
                    await _unitOfWork.SaveChangesAsync();
                    response.Status = true;
                    response.Message = "User's information updated successfully";
                    response.Data = user;
                    return Ok(response);
                }
                else
                {
                    response.Status = true;
                    response.Message = "No changes detected";
                    response.Data = user;
                    return Ok(response);
                }
            }
            catch (Exception)
            {
                response.Status = false;
                response.Message = "An error occurred while updating user's information";
                return BadRequest(response);
            }
        }



        [HttpPut("UpdatePassword")]
        public async Task<IActionResult> UpdatePassword([FromBody] UpdatePasswordRequestModel model)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                if (model == null || model.UserId <= 0 || string.IsNullOrEmpty(model.OldPassword) || string.IsNullOrEmpty(model.NewPassword))
                {
                    response.Status = false;
                    response.Message = "Invalid request data";
                    return BadRequest(response);
                }

                var user = await _unitOfWork.UserRepository.GetByIdAsync(model.UserId);

                if (user == null)
                {
                    response.Status = false;
                    response.Message = "User not found";
                    return NotFound(response);
                }

                // Use PasswordHasher to verify the old password
                var passwordHasher = new PasswordHasher<User>();
                var result = passwordHasher.VerifyHashedPassword(user, user.Password, model.OldPassword);

                if (result == PasswordVerificationResult.Failed)
                {
                    response.Status = false;
                    response.Message = "Incorrect old password";
                    return BadRequest(response);
                }

                // Hash the new password before saving
                user.Password = passwordHasher.HashPassword(user, model.NewPassword);

                await _unitOfWork.UserRepository.UpdateAsync(user);
                await _unitOfWork.SaveChangesAsync();

                response.Status = true;
                response.Message = "Password updated successfully";
                return Ok(response);
            }
            catch (Exception)
            {
                response.Status = false;
                response.Message = "An error occurred while updating the password";
                return StatusCode(500, response);
            }
        }


    }
}
