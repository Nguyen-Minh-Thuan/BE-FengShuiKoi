namespace FSK.APIService.RespondModel
{
    public class PatternColorRespondModel
    {
        public int PcolorId { get; set; }

        public int PatternId { get; set; }

        public int ColorId { get; set; }

        public string ColorName { get; set; }

        public double Values { get; set; }

        public double? ComputeValues {  get; set; }

        public List<ColorRespondModel> Color {  get; set; } = new List<ColorRespondModel>();

        public List<PatternRespondModel> Pattern { get; set; } = new List<PatternRespondModel>();

    }
}
