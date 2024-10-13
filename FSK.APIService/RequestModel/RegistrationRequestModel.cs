namespace FSK.APIService.RequestModel
{
    public class RegistrationRequestModel
    {
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public int Role { get; set; }
    }
}
