﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace FSK.Repository.Models;

public partial class ElementQuantity
{
    public int RecId { get; set; }

    public int ElementId { get; set; }

    public int Quantity { get; set; }

    public bool? IsActive { get; set; }

    public virtual Element Element { get; set; }
}