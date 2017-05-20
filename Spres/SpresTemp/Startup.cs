using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SpresTemp.Startup))]
namespace SpresTemp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
