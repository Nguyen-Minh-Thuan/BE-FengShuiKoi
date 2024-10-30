namespace FSK.APIService.Payment.Models
{
    public class AdsPaymentModel
    {
        public int? AdsId { get; set; }

        public int AdsTypeId { get; set; }

        public int UserId { get; set; }

        public int PackageId { get; set; }

        public string? Title { get; set; }

        public string? Content { get; set; }

        //public int StatusId { get; set; }

        public int ElementId { get; set; }

        public DateTime StartedDate { get; set; }

        //public DateTime? ExpiredDate { get; set; }

        //public int? Duration { get; set; }

        public string? ImageUrl { get; set; }

        //public bool? PaymentStatus { get; set; }

        public int Quantity { get; set; }
    }
}
