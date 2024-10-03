using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

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
            response.Data = await _unitOfWork.UserRepository.GetByIdAsync(id);

            if (response.Data == null)
            {
                response.Status = false;
                response.Message = "User not found";
                return BadRequest(response);
            }

            return Ok(response);
        }

        // POST: api/Products
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754    
        [HttpPost]
        [Route("Registration")]
        public async Task<IActionResult> PostUser(UserRegistration userDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var existingUser = await _unitOfWork.UserRepository.FirstOrDefaultAsync(x => x.Email == userDto.Email);
            if (existingUser != null)
            {
                return BadRequest("User already exists with the same email address.");
            }

            try
            {
                var user = new User
                {
                    UserName = userDto.UserName,
                    Password = userDto.Password,
                    Email = userDto.Email,
                    Bio = userDto.Bio,
                    ImageUrl = userDto.ImageUrl,
                    IsActive = userDto.IsActive,
                    Role = string.IsNullOrEmpty(userDto.Role) ? "User" : userDto.Role
                };

                await _unitOfWork.UserRepository.CreateAsync(user);
                await _unitOfWork.SaveChangesAsync();
                return CreatedAtAction("GetUser", new { id = user.UserId }, user);
            }
            catch (Exception ex)
            {
                // Log the exception
                return BadRequest("An error occurred while registering the user.");
            }
        }

        // PUT: api/Products/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("UpdateRole/{id}")]
        public async Task<IActionResult> UpdateUserRole(int id, string newRole)
        {
            var user = await _unitOfWork.UserRepository.GetByIdAsync(id);
            if (user == null)
            {
                return NotFound("User not found");
            }

            user.Role = newRole;

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

        [HttpPost("Login")]
        public async Task<IActionResult> Login(Login loginDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var user = await _unitOfWork.UserRepository.FirstOrDefaultAsync(u =>
                u.UserName == loginDto.UsernameOrEmail || u.Email == loginDto.UsernameOrEmail);

            if (user == null || user.Password != loginDto.Password) // Note: In a real application, use proper password hashing and verification
            {
                return Unauthorized("Invalid username/email or password");
            }

            // Here you would typically generate and return a JWT token for authenticated requests
            // For simplicity, we're just returning a success message
            return Ok(new { message = "Login successful", userId = user.UserId });
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


    }
}
