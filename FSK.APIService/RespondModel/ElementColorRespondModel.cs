namespace FSK.APIService.RespondModel
{
    public class ElementColorRespondModel
    {

        public int ElementColorId { get; set; }

        public int ElementId { get; set; }

        public int ColorId { get; set; }

        public double Values { get; set; }

        public string ColorName { get; set; }
        public ElementColorRespondModel Color { get; set; } = new ElementColorRespondModel();

        public List<ElementRespondModel> Element {get; set; } = new List<ElementRespondModel>();

    }
}
