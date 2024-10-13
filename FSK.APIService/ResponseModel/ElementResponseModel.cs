namespace FSK.APIService.ResponseModel
{
    public class ElementResponseModel
    {

        public int ElementId { get; set; }

        public string Element { get; set; }

        public string Description { get; set; }

        public List<ElementColorResponseModel> ElementsColor { get; set; } = new List<ElementColorResponseModel>();

    }
}
