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

        
    }
}