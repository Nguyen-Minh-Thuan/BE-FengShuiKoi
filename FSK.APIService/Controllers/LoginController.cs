using FSK.APIService.RequestModel;
using FSK.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using FSK.Repository.Models;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;
        private readonly JwtService _jwtService;

        public LoginController(UnitOfWork unitOfWork, JwtService jwtService)
        {
            _unitOfWork = unitOfWork;
            _jwtService = jwtService;
        }

        [HttpPost("Login")]
        public async Task<IActionResult> Login(LoginRequestModel loginDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Normalize the input username/email to lowercase for case-insensitive comparison
            var normalizedInput = loginDto.UsernameOrEmail.ToLower();

            // Fetch the user from the database
            var user = (await _unitOfWork.UserRepository.GetAllAsync()).Where(u =>
                u.UserName.ToLower() == normalizedInput || u.Email.ToLower() == normalizedInput).LastOrDefault();

            Boolean check = false;
            if (user.UserName == loginDto.UsernameOrEmail)
                check = true;
            if (user.Email == loginDto.UsernameOrEmail)
                check = true;

                if (user == null || check == false || user.IsActive == false)
            {
                return Unauthorized("Invalid username/email or password");
            }

            // Use PasswordHasher to verify the password
            var passwordHasher = new PasswordHasher<User>();
            var result = passwordHasher.VerifyHashedPassword(user, user.Password, loginDto.Password);

            if (result == PasswordVerificationResult.Failed)
            {
                return Unauthorized("Invalid username/email or password");
            }

            var token = _jwtService.GenerateToken(user.UserId, user.UserName, user.RoleId);

            return Ok(new { message = "Login successful", token = token, user = user });
        }
    }
}