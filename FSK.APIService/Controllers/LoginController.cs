using FSK.APIService.RequestModel;
using FSK.Repository;
using Microsoft.AspNetCore.Mvc;

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

            var user = await _unitOfWork.UserRepository.FirstOrDefaultAsync(u =>
                u.UserName == loginDto.UsernameOrEmail || u.Email == loginDto.UsernameOrEmail);

            if (user == null || user.Password != loginDto.Password) // Note: In a real application, use proper password hashing and verification
            {
                return Unauthorized("Invalid username/email or password");
            }

            var token = _jwtService.GenerateToken(user.UserId, user.UserName, user.RoleId);

            return Ok(new { message = "Login successful", token = token, user = user });
        }
    }
}