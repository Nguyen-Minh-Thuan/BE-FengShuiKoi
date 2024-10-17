namespace FSK.APIService.RequestModel
{
    public class UpdatePasswordRequestModel
    {
        public int UserId { get; set; }
        public string OldPassword { get; set; }
        public string NewPassword { get; set; }
    }
}
