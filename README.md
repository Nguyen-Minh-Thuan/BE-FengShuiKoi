
# Feng Shui Koi Consulting System

Feng Shui Koi is a .NET 8.0 web API project designed to handle various functionalities related to advertisements, payments, and Feng Shui services. 

This project is built using ASP.NET Core and Entity Framework Core.



## Tech Stack
- **Programming Language**: C# 12.0
- **Framework**: .NET 8.0
- **Web Framework**: ASP.NET Core
- **Data Access**: Entity Framework Core
- **Authentication**: JWT Bearer Authentication
- **API Documentation**: Swagger (using Microsoft.OpenApi.Models)
- **Database**: Microsoft SQL Server


## Run Locally

Clone the project:

```bash
  git clone https://github.com/Nguyen-Minh-Thuan/BE-FengShuiKoi.git
```

Restore the dependencies:

```bash
  dotnet restore
```

Update the database connection string in `appsettings.json`:

```bash
  "ConnectionStrings": {
    "DefaultConnection": "Server=your_server;
    Database=your_database;
    User Id=your_user;
    Password=your_password;"
}
```

Apply the database migrations:

```bash
  dotnet ef database update
```

Run the project:

```bash
  dotnet run
```
## Usage/Examples

Once the project is running, you can access the API endpoints using a tool like Postman or cURL. The base URL for the API will be `https://localhost:5001/api`.


