﻿using FSK.Repository;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Policy = "Staff")]
    public class StaffController : ControllerBase
    {

        private readonly UnitOfWork _unitOfWork;

        public StaffController(UnitOfWork unitOfWork)
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
            if (advertisement.StatusId != 2)
            {
                return BadRequest("This Advertisement are not allow to update Status");
            }
            //Approved
            advertisement.StatusId = 4;

            //Smth should have been here but idk for now :D


            //Deploying
            //advertisement.StatusId = 5;
            //advertisement.StartedDate = DateTime.Now;
            //advertisement.ExpiredDate = advertisement.StartedDate.Value.AddDays(advertisement.Duration.Value);

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

            if (advertisement.StatusId != 2)
            {
                return BadRequest("This Advertisement are not allow to update Status");
            }

            advertisement.StatusId = 3;
            advertisement.Reason = reason;

            // add a new property to the Advertisement model to store the decline reason, or not?
            // advertisement.DeclineReason = reason;

            await _unitOfWork.SaveChangesAsync();

            // This should be the refund proccess if payment was made, but since payment wasnt completed yet, imma comment this out
            //if (advertisement.PaymentStatus == true)
            //{
            //}

            return Ok(new { message = "Advertisement declined" });
        }


    }
}
