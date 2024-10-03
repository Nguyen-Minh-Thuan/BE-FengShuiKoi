using FSK.Repository.Models;

namespace FSK.APIService.RespondModel
{
    public class VarietyRespondModel
    {

        public int VarietyId { get; set; }

        public string VarietyName { get; set; }

        public string ImageUrl { get; set; }

        public string Description { get; set; }

        public double TotalPattern { get; set; }

        public List<PatternRespondModel> Patterns { get; set; } = new List<PatternRespondModel>();

    }
}
