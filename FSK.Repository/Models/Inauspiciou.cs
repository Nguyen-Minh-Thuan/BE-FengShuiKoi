﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace FSK.Repository.Models;

public partial class Inauspiciou
{
    public int InauspiciousId { get; set; }

    public int DirectionId { get; set; }

    public int KuaId { get; set; }

    public string Description { get; set; }

    public virtual Direction Direction { get; set; }

    public virtual Kua Kua { get; set; }
}