using FSK.Repository.Models;

namespace FSK.APIService.RespondModel
{
    public class PatternResponseModel
    {

        public int PatternId { get; set; }

        public int VarietyId { get; set; }

        public string PatternName { get; set; }

        public string ImageUrl { get; set; }

        public double PatternPoint {  get; set; }

        public List<PatternColorResponseModel> PatternColors { get; set; } = new List<PatternColorResponseModel>();

        public List<VarietyResponseModel> Variety { get; set; } = new List<VarietyResponseModel>();

    }
}
