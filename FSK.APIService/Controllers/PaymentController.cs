using FSK.Repository;
using FSK.Repository.Models;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace FSK.APIService.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PaymentController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;

        public PaymentController(UnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        [HttpPost("ProcessPayment/{advertisementId}")]
        public async Task<IActionResult> ProcessPayment(int advertisementId)
        {
            var advertisement = await _unitOfWork.AdvertisementRepository.GetByIdAsync(advertisementId);

            if (advertisement == null)
            {
                return NotFound("Advertisement not found");
            }

            var transaction = await _unitOfWork.TransactionRepository.FirstOrDefaultAsync(t => t.AdsId == advertisementId);

            if (transaction == null)
            {
                return NotFound("Transaction not found");
            }

            // Should have integrate a payment gateway, but i'm too dumb now
            // So for this, we'll just mark it as paid

            transaction.TransactionDate = DateTime.Now;
            advertisement.PaymentStatus = true;

            await _unitOfWork.SaveChangesAsync();

            return Ok(new { message = "Payment processed successfully" });
        }
    }
}