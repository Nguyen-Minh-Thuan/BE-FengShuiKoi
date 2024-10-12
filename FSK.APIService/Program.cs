
using FSK.Repository;
using FSK.Service.Services.Systems;
using System.Text.Json.Serialization;

namespace FSK.APIService
{
    public class Program
    {
        public static void Main(string[] args)
        {


            var builder = WebApplication.CreateBuilder(args);


            // Define CORS policy
            var MyAllowSpecificOrigins = "_myAllowSpecificOrigins";

            builder.Services.AddCors(options =>
            {
                options.AddPolicy(name: MyAllowSpecificOrigins,
                                  policy =>
                                  {
                                      // Allow requests from Vercel and localhost for testing
                                      policy.WithOrigins("https://koi-feng-shui.vercel.app", "http://localhost:5173")
                                            .AllowAnyHeader()    // Allow any header (like Authorization)
                                            .AllowAnyMethod();   // Allow any HTTP method (GET, POST, PUT, DELETE)
                                  });
            });

            // Add services to the container.

            builder.Services.AddControllers();

            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle

            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            builder.Services.AddScoped<UnitOfWork>();
            builder.Services.AddScoped<FengShuiService>();

            builder.Services.AddControllers().AddJsonOptions(options => options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseCors(MyAllowSpecificOrigins);

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
