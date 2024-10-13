namespace FSK.APIService.RequestModel
{
    public class UpdateAdvertisementRequestModel
    {
        public int AdvertisementId { get; set; }
        public int? AdsTypeId { get; set; }
        public int UserId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public int? ElementId { get; set; }
        public string ImageUrl { get; set; }
    }
}
