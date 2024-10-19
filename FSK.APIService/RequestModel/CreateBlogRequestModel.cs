namespace FSK.APIService.RequestModel
{
    public class CreateBlogRequestModel
    {
        public int UserId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public int StatusId { get; set; }
        public int ElementID { get; set; }
        public string ImageUrl { get; set; }
    }
}
