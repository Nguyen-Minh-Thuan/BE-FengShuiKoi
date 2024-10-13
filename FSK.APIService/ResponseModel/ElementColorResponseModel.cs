namespace FSK.APIService.ResponseModel
{
    public class ElementColorResponseModel
    {

        public int ElementColorId { get; set; }

        public int ElementId { get; set; }

        public int ColorId { get; set; }

        public double Values { get; set; }

        public List<ElementColorResponseModel> Color { get; set; } = new List<ElementColorResponseModel>();

        public List<ElementResponseModel> Element {get; set; } = new List<ElementResponseModel>();

    }
}
