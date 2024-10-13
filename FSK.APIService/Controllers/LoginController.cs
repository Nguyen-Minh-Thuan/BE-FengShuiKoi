using FSK.APIService.RequestModel;
using FSK.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;

        public LoginController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;

        [HttpPost("Login")]
        public async Task<IActionResult> Login(LoginRequestModel loginDto)
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
            return Ok(new { message = "Login successful", user = user });
        }
    }
}
