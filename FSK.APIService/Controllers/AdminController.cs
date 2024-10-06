using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace FSK.APIService.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AdminController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;

        public AdminController(UnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        [HttpPost("ApproveAdvertisement/{advertisementId}")]
        public async Task<IActionResult> ApproveAdvertisement(int advertisementId)
        {
            var advertisement = await _unitOfWork.AdvertisementRepository.GetByIdAsync(advertisementId);

            if (advertisement == null)
            {
                return NotFound("Advertisement not found");
            }

            if (advertisement.PaymentStatus == false)
            {
                return BadRequest("Payment must be completed before approval");
            }

            advertisement.Status = "Approved";

            await _unitOfWork.SaveChangesAsync();

            return Ok(new { message = "Advertisement approved successfully" });
        }

        [HttpPost("DeclineAdvertisement/{advertisementId}")]
        public async Task<IActionResult> DeclineAdvertisement(int advertisementId, [FromBody] string reason)
        {
            var advertisement = await _unitOfWork.AdvertisementRepository.GetByIdAsync(advertisementId);

            if (advertisement == null)
            {
                return NotFound("Advertisement not found");
            }

            advertisement.Status = "Declined";

            // add a new property to the Advertisement model to store the decline reason, or not?
            // advertisement.DeclineReason = reason;

            await _unitOfWork.SaveChangesAsync();

            // This should be the refund proccess if payment was made, but since payment wasnt completed yet, imma comment this out
            //if (advertisement.PaymentStatus == true)
            //{
            //}

            return Ok(new { message = "Advertisement declined", reason = reason });
        }
    }
}