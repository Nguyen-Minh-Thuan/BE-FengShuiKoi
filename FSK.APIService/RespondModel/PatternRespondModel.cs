using FSK.Repository.Models;

namespace FSK.APIService.RespondModel
{
    public class PatternRespondModel
    {

        public int PatternId { get; set; }

        public int VarietyId { get; set; }

        public string PatternName { get; set; }

        public string ImageUrl { get; set; }

        public double PatternPoint {  get; set; }

        public List<PatternColorRespondModel> PatternColors { get; set; } = new List<PatternColorRespondModel>();

        public List<VarietyRespondModel> Variety { get; set; } = new List<VarietyRespondModel>();
    }
}
