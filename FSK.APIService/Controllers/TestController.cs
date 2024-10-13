using FSK.APIService.Payment;
using FSK.APIService.Payment.Models;
using FSK.APIService.RequestModel;
using FSK.APIService.ResponseModel;
using FSK.Repository;
using FSK.Repository.Models;
using FSK.Service.Services.Systems;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TestController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;
        private readonly FengShuiService _fengShuiService;
        private readonly IVnPayService _vnPayService;
        public TestController(UnitOfWork unitOfWork, FengShuiService fengShuiService, IVnPayService vnPayService)
        {
            _unitOfWork = unitOfWork;
            _fengShuiService = fengShuiService;
            _vnPayService = vnPayService;
        }



        [HttpPost("TestFunc")]
        public IActionResult CreatePaymentUrl()
        {


            PaymentInformationModel model = new PaymentInformationModel { Name = "Testing Product", Amount = 100000, OrderDescription = "This is a testing product", OrderType = "FengShui Shit" };

            var url = _vnPayService.CreatePaymentUrl(model, HttpContext);

            BaseResponseModel response = new BaseResponseModel();

            response.Status = true;
            response.Message = "Success";
            response.Data = url;

            //return Redirect(url);

            return Ok(response);
        }

        //[HttpPost("TestFunc2")]
        //public IActionResult CreatePaymentUrl(PaymentInformationModel model)
        //{

        //    var url = _vnPayService.CreatePaymentUrl(model, HttpContext);

        //    BaseResponseModel response = new BaseResponseModel();

        //    //response.Status = true;
        //    //response.Message = "Success";
        //    //response.Data = url;

        //    return Redirect(url);

        //    //return Ok(response);
        //}

        [HttpGet("CheckData")]
        public IActionResult PaymentCallback()
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                response.Data = _vnPayService.PaymentExecute(Request.Query);
                return Ok(response);
            }
            catch (Exception err)
            {

                response.Status =false;
                response.Message = err.ToString();
                return BadRequest(response);
            }
            
        }

        /*

        [HttpGet("TestFunc")]
        public async Task<ActionResult<IEnumerable<Element>>> GetPoint(int elementID)
        {
            BaseResponseModel response = new BaseResponseModel();

            response.Status = true;
            response.Message = "Success";

            var element = await _unitOfWork.ElementColorRepository.GetAllAsync();
            var getdata = element.Where(x => x.ElementId == elementID);
            //var test = output.Select(Color => )
            response.Data = getdata;


            if (response.Data == null)
            {
                response.Status = false;
                response.Message = "User not found";
                return BadRequest(response);
            }

            return Ok(response);
        }

        [HttpGet("GetShape")]
        public async Task<ActionResult<Element>> GetPondShape(int id)
        {
            BaseResponseModel response = new BaseResponseModel();

            response.Status = true;
            response.Message = "Success";

            var element = await _unitOfWork.ElementRepository.GetByIdAsync(id);
            var pond = await _unitOfWork.PondRepository.GetAllAsync();
            var shape = await _unitOfWork.ShapeRepository.GetAllAsync();
            foreach (Shape item in shape)
            {
                item.Ponds = null;
            }
            response.Data = element;


            if (response.Data == null)
            {
                response.Status = false;
                response.Message = "User not found";
                return BadRequest(response);
            }

            return Ok(response);
        }

        [HttpGet("GetDirection")]
        public async Task<ActionResult<Element>> GetDirection(int id)
        {
            BaseResponseModel response = new BaseResponseModel();

            response.Status = true;
            response.Message = "Success";

            var kua = await _unitOfWork.KuaRepository.GetByIdAsync(id);
            var auspicious = await _unitOfWork.AuspiciousRepository.GetAllAsync();
            var inauspicoous = await _unitOfWork.InauspiciousRepository.GetAllAsync();
            var direction = await _unitOfWork.DirectionRepository.GetAllAsync();
            foreach (var item in direction) 
            {
                item.Auspicious = null;
                item.Inauspicious = null;
            }

            response.Data = kua;


            if (response.Data == null)
            {
                response.Status = false;
                response.Message = "User not found";
                return BadRequest(response);
            }

            return Ok(response);
        }

        [HttpGet("Koi")]
        public async Task<ActionResult<Element>> GetKoi(int id)
        {
            BaseResponseModel response = new BaseResponseModel();

            response.Status = true;
            response.Message = "Success";

            var element = await _unitOfWork.ElementRepository.GetByIdAsync(id);
            var elementColor = await _unitOfWork.ElementColorRepository.GetAllAsync();
            var color = await _unitOfWork.ColorRepository.GetAllAsync();
            foreach (Color n in color)
            {
                n.ElementColors = null;
            }
            var patternColor = await _unitOfWork.PatternColorRepository.GetAllAsync();
            foreach (PatternColor n in patternColor)
            {
                n.Color = null;
            }

            var pattern = await _unitOfWork.PatternRepository.GetAllAsync();
            
            var variety = await _unitOfWork.VarietyRepository.GetAllAsync();
            foreach (Variety n in variety)
            {
                n.Patterns = null;
            }

            //var pond = await _unitOfWork.PondRepository.GetAllAsync();
            //var shape = await _unitOfWork.ShapeRepository.GetAllAsync();
            //foreach (Shape item in shape)
            //{
            //    item.Ponds = null;
            //}
            var getData = element;
            response.Data = element;


            if (response.Data == null)
            {
                response.Status = false;
                response.Message = "User not found";
                return BadRequest(response);
            }

            return Ok(response);
        }

        [HttpGet("CalculateDir")]
        public async Task<ActionResult<Element>> CalculateDirection(int elementID, int kuaID)
        {
            BaseResponseModel response = new BaseResponseModel();

            response.Status = true;
            response.Message = "Success";

            var element = await _unitOfWork.ElementRepository.GetByIdAsync(elementID);
            var pond = await _unitOfWork.PondRepository.GetAllAsync();
            var shape = await _unitOfWork.ShapeRepository.GetAllAsync();
            foreach (Shape item in shape)
            {
                item.Ponds = null;
            }

            var kua = await _unitOfWork.KuaRepository.GetByIdAsync(kuaID);
            var auspicious = await _unitOfWork.AuspiciousRepository.GetAllAsync();
            var inauspicoous = await _unitOfWork.InauspiciousRepository.GetAllAsync();
            var direction = await _unitOfWork.DirectionRepository.GetAllAsync();
            foreach (var item in direction)
            {
                item.Auspicious = null;
                item.Inauspicious = null;
            }

            response.Data = new { Direction = kua, PondShape = element };


            if (response.Data == null)
            {
                response.Status = false;
                response.Message = "User not found";
                return BadRequest(response);
            }

            return Ok(response);
        }

        */
        //test Git

    }
}
