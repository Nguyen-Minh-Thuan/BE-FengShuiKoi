﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace FSK.Repository.Models;

public partial class AdsType
{
    public int AdsTypeId { get; set; }

    public string TypeName { get; set; }

    public bool? IsActive { get; set; }

    public virtual ICollection<Advertisement> Advertisements { get; set; } = new List<Advertisement>();
}