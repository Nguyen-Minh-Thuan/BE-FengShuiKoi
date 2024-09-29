﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace FSK.Repository.Models;

public partial class Advertisement
{
    public int AdsId { get; set; }

    public int UserId { get; set; }

    public int PackageId { get; set; }

    public string Title { get; set; }

    public string Content { get; set; }

    public string Status { get; set; }

    public int ElementId { get; set; }

    public DateTime ExpiredDate { get; set; }

    public string ImageUrl { get; set; }

    public bool? PaymentStatus { get; set; }

    public virtual Package Package { get; set; }

    public virtual ICollection<Transaction> Transactions { get; set; } = new List<Transaction>();

    public virtual User User { get; set; }
}