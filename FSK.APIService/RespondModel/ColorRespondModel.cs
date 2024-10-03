namespace FSK.APIService.RespondModel
{
    public class ColorRespondModel
    {

        public int ColorID { get; set;}

        public string Name { get; set;}

        public List<ElementColorRespondModel> ElementColors { get; set;} = new List<ElementColorRespondModel>();

        public List<PatternColorRespondModel> PatternColors { get; set;} = new List<PatternColorRespondModel>();

    }
}
