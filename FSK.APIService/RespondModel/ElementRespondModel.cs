namespace FSK.APIService.RespondModel
{
    public class ElementRespondModel
    {

        public int ElementId { get; set; }

        public string Element { get; set; }

        public string Description { get; set; }

        public List<ElementColorRespondModel> ElementsColor { get; set; } = new List<ElementColorRespondModel>();

    }
}
