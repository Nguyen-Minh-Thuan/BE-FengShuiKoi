namespace FSK.APIService.RespondModel
{
    public class ElementColorResponseModel
    {

        public int ElementColorId { get; set; }

        public int ElementId { get; set; }

        public int ColorId { get; set; }

        public double Values { get; set; }

        public string ColorName { get; set; }
        public ElementColorResponseModel Color { get; set; } = new ElementColorResponseModel();

        public List<ElementResponseModel> Element {get; set; } = new List<ElementResponseModel>();

    }
}
