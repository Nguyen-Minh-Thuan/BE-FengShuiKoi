﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace FSK.Repository.Models;

public partial class Shape
{
    public int ShapeId { get; set; }

    public string Shape1 { get; set; }

    public bool? IsActive { get; set; }

    public virtual ICollection<Pond> Ponds { get; set; } = new List<Pond>();
}