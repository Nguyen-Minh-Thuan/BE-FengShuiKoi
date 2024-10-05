using FSK.Repository.Models;
using FSK.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using FSK.APIService.RequestModel;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RegistrationController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;

        public RegistrationController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;



        [HttpPost]
        [Route("Registration")]
        public async Task<IActionResult> PostUser(RegistrationRequestModel userDto)
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
                    Role = 3
                };

                await _unitOfWork.UserRepository.CreateAsync(user);
                await _unitOfWork.SaveChangesAsync();
                return Ok(new { message = "User registered successfully", userId = user.UserId });
            }
            catch (Exception ex)
            {
                // Log the exception
                return BadRequest("An error occurred while registering the user.");
            }
        }
    }
}
