namespace FSK.APIService.RequestModel
{
    public class CreateAdvertisementRequestModel
    {
        public int UserId { get; set; }
        public int AdsTypeId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public int PackageId { get; set; }
        public int ElementId { get; set; }
        public string ImageUrl { get; set; }
        public DateTime StartedDate { get; set; }
    }
}
