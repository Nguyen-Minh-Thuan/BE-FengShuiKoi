namespace FSK.APIService.RequestModel
{
    public class UpdatePackageRequestModel
    {
        public string PackageName { get; set; }

        public int Duration { get; set; }

        public decimal? Price { get; set; }
    }
}
