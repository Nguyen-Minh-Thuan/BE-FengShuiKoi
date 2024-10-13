namespace FSK.APIService.RequestModel
{
    public class SubmitAdvertisementRequestModel
    {
        public int AdvertisementId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public int? ElementId { get; set; }
        public string ImageUrl { get; set; }
    }
}
