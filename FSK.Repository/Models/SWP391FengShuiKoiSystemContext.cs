﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace FSK.Repository.Models;

public partial class SWP391FengShuiKoiSystemContext : DbContext
{
    public SWP391FengShuiKoiSystemContext()
    {
    }

    public SWP391FengShuiKoiSystemContext(DbContextOptions<SWP391FengShuiKoiSystemContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AdsType> AdsTypes { get; set; }

    public virtual DbSet<Advertisement> Advertisements { get; set; }

    public virtual DbSet<Auspiciou> Auspicious { get; set; }

    public virtual DbSet<Color> Colors { get; set; }

    public virtual DbSet<Direction> Directions { get; set; }

    public virtual DbSet<DirectionGroup> DirectionGroups { get; set; }

    public virtual DbSet<Element> Elements { get; set; }

    public virtual DbSet<ElementColor> ElementColors { get; set; }

    public virtual DbSet<ElementQuantity> ElementQuantities { get; set; }

    public virtual DbSet<General> Generals { get; set; }

    public virtual DbSet<Inauspiciou> Inauspicious { get; set; }

    public virtual DbSet<Kua> Kuas { get; set; }

    public virtual DbSet<Package> Packages { get; set; }

    public virtual DbSet<Pattern> Patterns { get; set; }

    public virtual DbSet<PatternColor> PatternColors { get; set; }

    public virtual DbSet<Pond> Ponds { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Shape> Shapes { get; set; }

    public virtual DbSet<Status> Statuses { get; set; }

    public virtual DbSet<Transaction> Transactions { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<Variety> Varieties { get; set; }

    //    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    //#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
    //        => optionsBuilder.UseSqlServer("Data Source=MINHTHUAN\\SQLEXPRESS;Initial Catalog=SWP391FengShuiKoiSystem;Persist Security Info=True;User ID=sa;Password=12345;Encrypt=False");

    public static string GetConnectionString(string connectionStringName)
    {
        var config = new ConfigurationBuilder()
            .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
            .AddJsonFile("appsettings.json")
            .Build();

        string connectionString = config.GetConnectionString(connectionStringName);
        return connectionString;
    }
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) => optionsBuilder.UseSqlServer(GetConnectionString("DefaultConnection"));

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AdsType>(entity =>
        {
            entity.Property(e => e.TypeName).HasMaxLength(100);
        });

        modelBuilder.Entity<Advertisement>(entity =>
        {
            entity.HasKey(e => e.AdsId);

            entity.ToTable("Advertisement");

            entity.Property(e => e.Content).HasMaxLength(3000);
            entity.Property(e => e.ElementId).HasColumnName("ElementID");
            entity.Property(e => e.ExpiredDate).HasColumnType("datetime");
            entity.Property(e => e.ImageUrl).HasMaxLength(250);
            entity.Property(e => e.PackageId).HasColumnName("PackageID");
            entity.Property(e => e.StartedDate).HasColumnType("datetime");
            entity.Property(e => e.Title)
                .IsRequired()
                .HasMaxLength(50);

            entity.HasOne(d => d.AdsType).WithMany(p => p.Advertisements)
                .HasForeignKey(d => d.AdsTypeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Advertisement_AdsTypes");

            entity.HasOne(d => d.Package).WithMany(p => p.Advertisements)
                .HasForeignKey(d => d.PackageId)
                .HasConstraintName("FK_Advertisement_Package");

            entity.HasOne(d => d.Status).WithMany(p => p.Advertisements)
                .HasForeignKey(d => d.StatusId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Advertisement_Status");

            entity.HasOne(d => d.User).WithMany(p => p.Advertisements)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Advertisement_User");
        });

        modelBuilder.Entity<Auspiciou>(entity =>
        {
            entity.HasKey(e => e.AuspiciousId);

            entity.Property(e => e.AuspiciousId).HasColumnName("AuspiciousID");
            entity.Property(e => e.Description)
                .IsRequired()
                .HasMaxLength(300);
            entity.Property(e => e.DirectionId).HasColumnName("DirectionID");
            entity.Property(e => e.KuaId).HasColumnName("KuaID");

            entity.HasOne(d => d.Direction).WithMany(p => p.Auspicious)
                .HasForeignKey(d => d.DirectionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Auspicious_Direction");

            entity.HasOne(d => d.Kua).WithMany(p => p.Auspicious)
                .HasForeignKey(d => d.KuaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Auspicious_Kua");
        });

        modelBuilder.Entity<Color>(entity =>
        {
            entity.ToTable("Color");

            entity.Property(e => e.ColorId).HasColumnName("ColorID");
            entity.Property(e => e.Name)
                .IsRequired()
                .HasMaxLength(25);
        });

        modelBuilder.Entity<Direction>(entity =>
        {
            entity.ToTable("Direction");

            entity.Property(e => e.DirectionId).HasColumnName("DirectionID");
            entity.Property(e => e.DirectionName)
                .IsRequired()
                .HasMaxLength(25);
            entity.Property(e => e.GroupId).HasColumnName("GroupID");

            entity.HasOne(d => d.Group).WithMany(p => p.Directions)
                .HasForeignKey(d => d.GroupId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Direction_DirectionGroup");
        });

        modelBuilder.Entity<DirectionGroup>(entity =>
        {
            entity.HasKey(e => e.GroupId);

            entity.ToTable("DirectionGroup");

            entity.Property(e => e.GroupId).HasColumnName("GroupID");
            entity.Property(e => e.Description)
                .IsRequired()
                .HasMaxLength(300);
            entity.Property(e => e.GroupName)
                .IsRequired()
                .HasMaxLength(25);
        });

        modelBuilder.Entity<Element>(entity =>
        {
            entity.ToTable("Element");

            entity.Property(e => e.ElementId).HasColumnName("ElementID");
            entity.Property(e => e.Description).HasMaxLength(500);
            entity.Property(e => e.Element1)
                .IsRequired()
                .HasMaxLength(25)
                .HasColumnName("Element");
        });

        modelBuilder.Entity<ElementColor>(entity =>
        {
            entity.ToTable("ElementColor");

            entity.Property(e => e.ElementColorId).HasColumnName("ElementColorID");
            entity.Property(e => e.ColorId).HasColumnName("ColorID");
            entity.Property(e => e.ElementId).HasColumnName("ElementID");

            entity.HasOne(d => d.Color).WithMany(p => p.ElementColors)
                .HasForeignKey(d => d.ColorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ElementColor_Color");

            entity.HasOne(d => d.Element).WithMany(p => p.ElementColors)
                .HasForeignKey(d => d.ElementId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ElementColor_Element");
        });

        modelBuilder.Entity<ElementQuantity>(entity =>
        {
            entity.HasKey(e => e.RecId);

            entity.ToTable("ElementQuantity");

            entity.Property(e => e.RecId).HasColumnName("RecID");
            entity.Property(e => e.ElementId).HasColumnName("ElementID");

            entity.HasOne(d => d.Element).WithMany(p => p.ElementQuantities)
                .HasForeignKey(d => d.ElementId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ElementQuantity_Element");
        });

        modelBuilder.Entity<General>(entity =>
        {
            entity.ToTable("General");

            entity.Property(e => e.GeneralId).HasColumnName("GeneralID");
            entity.Property(e => e.ElementId).HasColumnName("ElementID");
            entity.Property(e => e.KuaId).HasColumnName("KuaID");

            entity.HasOne(d => d.Element).WithMany(p => p.Generals)
                .HasForeignKey(d => d.ElementId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_General_Element");

            entity.HasOne(d => d.Kua).WithMany(p => p.Generals)
                .HasForeignKey(d => d.KuaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_General_Kua");
        });

        modelBuilder.Entity<Inauspiciou>(entity =>
        {
            entity.HasKey(e => e.InauspiciousId);

            entity.Property(e => e.InauspiciousId).HasColumnName("InauspiciousID");
            entity.Property(e => e.Description)
                .IsRequired()
                .HasMaxLength(300);
            entity.Property(e => e.DirectionId).HasColumnName("DirectionID");
            entity.Property(e => e.KuaId).HasColumnName("KuaID");

            entity.HasOne(d => d.Direction).WithMany(p => p.Inauspicious)
                .HasForeignKey(d => d.DirectionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Inauspicious_Direction");

            entity.HasOne(d => d.Kua).WithMany(p => p.Inauspicious)
                .HasForeignKey(d => d.KuaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Inauspicious_Kua");
        });

        modelBuilder.Entity<Kua>(entity =>
        {
            entity.ToTable("Kua");

            entity.Property(e => e.KuaId).HasColumnName("KuaID");
            entity.Property(e => e.Description)
                .IsRequired()
                .HasMaxLength(500);
            entity.Property(e => e.KuaName)
                .IsRequired()
                .HasMaxLength(25);
        });

        modelBuilder.Entity<Package>(entity =>
        {
            entity.HasKey(e => e.PackageId).HasName("PK_PackageID");

            entity.ToTable("Package");

            entity.Property(e => e.PackageId).HasColumnName("PackageID");
            entity.Property(e => e.PackageName).HasMaxLength(50);
            entity.Property(e => e.Price).HasColumnType("decimal(18, 2)");
        });

        modelBuilder.Entity<Pattern>(entity =>
        {
            entity.ToTable("Pattern");

            entity.Property(e => e.PatternId).HasColumnName("PatternID");
            entity.Property(e => e.ImageUrl)
                .HasMaxLength(250)
                .HasColumnName("ImageURL");
            entity.Property(e => e.PatternName)
                .IsRequired()
                .HasMaxLength(25);
            entity.Property(e => e.VarietyId).HasColumnName("VarietyID");

            entity.HasOne(d => d.Variety).WithMany(p => p.Patterns)
                .HasForeignKey(d => d.VarietyId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Pattern_Variety");
        });

        modelBuilder.Entity<PatternColor>(entity =>
        {
            entity.HasKey(e => e.PcolorId);

            entity.ToTable("PatternColor");

            entity.Property(e => e.PcolorId).HasColumnName("PColorID");
            entity.Property(e => e.ColorId).HasColumnName("ColorID");
            entity.Property(e => e.PatternId).HasColumnName("PatternID");

            entity.HasOne(d => d.Color).WithMany(p => p.PatternColors)
                .HasForeignKey(d => d.ColorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PatternColor_Color");

            entity.HasOne(d => d.Pattern).WithMany(p => p.PatternColors)
                .HasForeignKey(d => d.PatternId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PatternColor_Pattern");
        });

        modelBuilder.Entity<Pond>(entity =>
        {
            entity.ToTable("Pond");

            entity.Property(e => e.PondId).HasColumnName("PondID");
            entity.Property(e => e.ElementId).HasColumnName("ElementID");
            entity.Property(e => e.ShapeId).HasColumnName("ShapeID");

            entity.HasOne(d => d.Element).WithMany(p => p.Ponds)
                .HasForeignKey(d => d.ElementId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Pond_Element");

            entity.HasOne(d => d.Shape).WithMany(p => p.Ponds)
                .HasForeignKey(d => d.ShapeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Pond_Shape");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.ToTable("Role");

            entity.Property(e => e.RoleId).HasColumnName("RoleID");
            entity.Property(e => e.RoleName)
                .IsRequired()
                .HasMaxLength(50);
        });

        modelBuilder.Entity<Shape>(entity =>
        {
            entity.ToTable("Shape");

            entity.Property(e => e.ShapeId).HasColumnName("ShapeID");
            entity.Property(e => e.Shape1)
                .IsRequired()
                .HasMaxLength(25)
                .HasColumnName("Shape");
        });

        modelBuilder.Entity<Status>(entity =>
        {
            entity.ToTable("Status");

            entity.Property(e => e.Status1)
                .IsRequired()
                .HasMaxLength(50)
                .HasColumnName("Status");
        });

        modelBuilder.Entity<Transaction>(entity =>
        {
            entity.ToTable("Transaction");

            entity.Property(e => e.TransactionId).HasColumnName("TransactionID");
            entity.Property(e => e.PackageId).HasColumnName("PackageID");
            entity.Property(e => e.PaymentMethod)
                .IsRequired()
                .HasMaxLength(50);
            entity.Property(e => e.TotalPrice).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.TransactionDate).HasColumnType("datetime");
            entity.Property(e => e.TransactionDetail)
                .IsRequired()
                .HasMaxLength(3000);

            entity.HasOne(d => d.Ads).WithMany(p => p.Transactions)
                .HasForeignKey(d => d.AdsId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Transaction_Advertisement");

            entity.HasOne(d => d.User).WithMany(p => p.Transactions)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Transaction_User");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.ToTable("User");

            entity.Property(e => e.Bio).HasMaxLength(250);
            entity.Property(e => e.Email)
                .IsRequired()
                .HasMaxLength(50);
            entity.Property(e => e.ImageUrl).HasMaxLength(250);
            entity.Property(e => e.Password)
                .IsRequired()
                .HasMaxLength(50);
            entity.Property(e => e.RoleId).HasColumnName("RoleID");
            entity.Property(e => e.UserName)
                .IsRequired()
                .HasMaxLength(50);

            entity.HasOne(d => d.Role).WithMany(p => p.Users)
                .HasForeignKey(d => d.RoleId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_User_Role");
        });

        modelBuilder.Entity<Variety>(entity =>
        {
            entity.ToTable("Variety");

            entity.Property(e => e.VarietyId).HasColumnName("VarietyID");
            entity.Property(e => e.Description).HasMaxLength(1500);
            entity.Property(e => e.ImageUrl)
                .HasMaxLength(250)
                .HasColumnName("ImageURL");
            entity.Property(e => e.VarietyName)
                .IsRequired()
                .HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}