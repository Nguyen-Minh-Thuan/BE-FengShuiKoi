namespace FSK.APIService.ResponseModel
{
    public class ColorResponseModel
    {

        public int ColorID { get; set;}

        public string Name { get; set;}

        public List<ElementColorResponseModel> ElementColors { get; set;} = new List<ElementColorResponseModel>();

        public List<PatternColorResponseModel> PatternColors { get; set;} = new List<PatternColorResponseModel>();

    }
}
