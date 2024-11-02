using FSK.Repository.Models;

namespace FSK.APIService.ResponseModel
{
    public class VarietyResponseModel
    {

        public int VarietyId { get; set; }

        public string VarietyName { get; set; }

        public string ImageUrl { get; set; }

        public string Description { get; set; }

        public double TotalPattern { get; set; }

        public Boolean? IsActive { get; set; }

        public List<PatternResponseModel> Patterns { get; set; } = new List<PatternResponseModel>();

    }
}
