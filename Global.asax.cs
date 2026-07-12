using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace WebApplicationFailDataDemo
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            Application["TotalVisitors"] = 0;
        }
        void Session_Start(object sender, EventArgs e)
        {
            // Increment total visitors when a new session starts
            Application.Lock();
            Application["TotalVisitors"] = (int)Application["TotalVisitors"] + 1;
            Application.UnLock();
        }
    }
}