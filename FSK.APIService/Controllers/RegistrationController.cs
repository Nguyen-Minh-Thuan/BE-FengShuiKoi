using FSK.Repository.Models;
using FSK.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using FSK.APIService.RequestModel;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

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

            var isEmail = IsValidEmail(userDto.Email);
            if (isEmail == false)
            {
                return BadRequest("Invalid email address!");
            }

            var existingUser = (await _unitOfWork.UserRepository.GetAllAsync()).Where(x => x.UserName == userDto.UserName).LastOrDefault();
            if (existingUser != null)
            {
                if (existingUser.IsActive != false)
                    return BadRequest("Username already taken by someone else.");
            }
            var existingEmail = (await _unitOfWork.UserRepository.GetAllAsync()).Where(x => x.Email == userDto.Email).LastOrDefault();
            if (existingEmail != null)
            {
                if (existingEmail.IsActive != false)
                    return BadRequest("User already exists with the same email address.");
            }

            try
            {
                var user = new User
                {
                    UserName = userDto.UserName,
                    Email = userDto.Email,
                    RoleId = 3, // Assuming 3 is the Member role ID\
                    CreatedDate = DateTime.Now,
                    IsActive = true
                };

                // Hash the password
                var passwordHasher = new PasswordHasher<User>();
                user.Password = passwordHasher.HashPassword(user, userDto.Password);

                await _unitOfWork.UserRepository.CreateAsync(user);
                await _unitOfWork.SaveChangesAsync();
                return Ok(new { message = "User registered successfully", userId = user.UserId });
            }
            catch (DbUpdateException dbEx)
            {
                // Log the exception details
                return BadRequest($"An error occurred while saving the user: {dbEx.InnerException?.Message}");
            }
            catch (Exception ex)
            {
                return BadRequest($"An error occurred while registering the user: {ex.Message}. Inner Exception: {ex.InnerException?.Message}");
            }
        }

        private static bool IsValidEmail(string email)
        {
            var trimmedEmail = email.Trim();

            if (trimmedEmail.EndsWith("."))
            {
                return false; // suggested by @TK-421
            }
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == trimmedEmail;
            }
            catch
            {
                return false;
            }
        }

    }
}
