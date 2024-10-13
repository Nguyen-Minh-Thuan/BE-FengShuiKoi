namespace FSK.APIService.RespondModel
{
    public class PatternColorResponseModel
    {
        public int PcolorId { get; set; }

        public int PatternId { get; set; }

        public int ColorId { get; set; }

        public string ColorName { get; set; }

        public double Values { get; set; }

        public double? ComputeValues {  get; set; }

        public List<ColorResponseModel> Color {  get; set; } = new List<ColorResponseModel>();

        public List<PatternResponseModel> Pattern { get; set; } = new List<PatternResponseModel>();

    }
}
