using FluentAssertions;
using Moq;
using Xunit;

namespace Scheduler.Tdd
{
    public class SchedulerHostedServiceTests
    {
        private readonly IHostBuilder _hostBuilder;
        public SchedulerHostedServiceTests()
        {
            _hostBuilder = new HostBuilder()
                .ConfigureScheduler<SchedulerHostedService>()
                .ConfigureWebHost(webBuilder =>
                {
                    webBuilder
                        .ConfigureAppConfiguration((context, configBuilder) =>
                        {
                            configBuilder.AddEnvironmentVariables();
                        })
                        .ConfigureServices(services =>
                        {
                            services.AddControllers();
                        })
                        .Configure(appBuilder =>
                        {
                            appBuilder
                                .UseRouting()
                                .UseEndpoints(endpoints =>
                                {
                                    endpoints.Map("/api/healthz", async request =>
                                    {
                                        string payload = "All working!";
                                        request.Response.StatusCode = (int)HttpStatusCode.OK;
                                        await request.Response.Body.WriteAsync(Encoding.UTF8.GetBytes(payload));
                                    });
                                });
                        })
                        .UseTestServer();
                });
        }

        [Fact]
        public async void TestServer_Should_ReplyResponse()
        {
            // Arrange
            var host = _hostBuilder.Build();
            host.Start();
            var client = host.GetTestClient();

            // Act
            var result = await client.GetAsync("/api/healthz");
            var content = await result.Content.ReadAsStringAsync();

            // Assert
            result.Should().NotBeNull()
                .And.Subject.StatusCode.Should().Be(HttpStatusCode.OK);
            content.Should().Be("All working!");
        }       
    }
}
