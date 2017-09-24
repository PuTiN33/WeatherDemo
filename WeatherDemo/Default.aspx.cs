//------------------------------------------------------------------------------------------------------------------------
//Copyright© CCI. All rights reserved.	
//Name: Default.aspx   Description: WeatherDemo
//Revision: 1.00  Created  Date: 2017/09/24 Created ID: Ed
//------------------------------------------------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Web.Services;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    #region 中央氣象局 web API
	[WebMethod]
	public static string cwb(string loc)
	{
		string requestUrl = @"http://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-061?locationName=" + loc + "&elementName=Wx,Wind&sort=time";
		string value = "";
		try
		{
			HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(requestUrl);
			request.Method = "GET";
			request.ContentType = "application/json;charset=utf-8";
			request.Headers.Add("Authorization", ConfigurationManager.AppSettings["Authorization"]); //中央氣象局 帳號申請 KEY
			request.Proxy.Credentials = CredentialCache.DefaultNetworkCredentials;
			using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
			{
				using (Stream stream = response.GetResponseStream())
				{
					StreamReader reader = new StreamReader(stream, System.Text.Encoding.UTF8);
					value = reader.ReadToEnd();
				}
			}
		}
		catch (Exception e)
		{
			Console.WriteLine(e.Message);
			return null;
		}
		return value;
	}
	#endregion
}