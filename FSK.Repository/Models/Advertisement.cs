﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace FSK.Repository.Models;

public partial class Advertisement
{
    public int AdsId { get; set; }

    public int AdsTypeId { get; set; }

    public int UserId { get; set; }

    public int? PackageId { get; set; }

    public string Title { get; set; }

    public string Content { get; set; }

    public int StatusId { get; set; }

    public int ElementId { get; set; }

    public DateTime? StartedDate { get; set; }

    public DateTime? ExpiredDate { get; set; }

    public int? Duration { get; set; }

    public string ImageUrl { get; set; }

    public string Reason { get; set; }

    public bool? PaymentStatus { get; set; }

    public DateTime? CreatedDate { get; set; }

    public bool? IsActive { get; set; }

    public virtual AdsType AdsType { get; set; }

    public virtual Element Element { get; set; }

    public virtual ICollection<Interact> Interacts { get; set; } = new List<Interact>();

    public virtual Package Package { get; set; }

    public virtual Status Status { get; set; }

    public virtual ICollection<Transaction> Transactions { get; set; } = new List<Transaction>();

    public virtual User User { get; set; }
}