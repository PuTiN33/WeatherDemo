<%--
//------------------------------------------------------------------------------------------------------------------------
//Copyright© CCI. All rights reserved.	
//Name: Default.aspx   Description: WeatherDemo
//Revision: 1.00  Created  Date: 2017/09/24 Created ID: Ed  
//------------------------------------------------------------------------------------------------------------------------
--%>


<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>WeatherDemo</title>
    <script src="js/jquery-1.12.4.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="js/jquery.blockUI.min.js"></script>
    <script src="js/custom.js"></script>
<!--Weather css-->
    <link href="css/weather-icons.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
        <div class="row" id="my_weather">
		  <div class="row">
			<div class="col-md-12">
			  <span id="span_weather"></span>
			</div>
		  </div>
		  <div class="row">
			<div class="col-md-12">
			  <span id="table_weather"></span>
			</div>
		  </div>
		</div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            CallWeather("文山區");
        })
		
		function CallWeather(loc) {
        $.ajax({
            method: "POST",
            data: "{'loc':'" + loc + "'}",
            url: "Default.aspx/cwb",
            contentType: "application/json;",
            method: "POST",
            dataType: "json",
            //timeout: 2000,
            success: function (data) {
                var vJSONData = JSON.parse(data.d);
                if (vJSONData) {
                    var title = "天氣預報 - " + vJSONData["records"].locations[0].location[0].locationName;
                    var result = new Array();
                    $.each(vJSONData["records"].locations[0].location[0].weatherElement[0].time, function (key, val) {
                        if (val.startTime.substring(11, 13) == "12" || val['startTime'].substring(11, 13) == "18") {
                            var inner = {
                                startTime: val.startTime.substring(5, 16),
                                elementValue: val.elementValue,
                                parameterValue: val.parameter[0].parameterValue
                            }
                            result.push(inner);
                        }
                    });
                    var table_weather = "";
                    var table_date = "";

                    for (var i = 0; i < result.length ; i++) {
                        table_date += "<tr><td>" + result[i]["startTime"] + "</td><td><div class='icon'><i class='wi wi-day-" + result[i]["parameterValue"] + "'></i>" + result[i]["elementValue"] + "</div></td>"
                    }
                    table_weather = "<table class='table-bordered text-center' style='width:100%;'>" + table_date + "</table>";

                    $("#span_weather").children().remove();
                    $("#span_weather").append("<h3 style='margin-bottom:15px;'>" + title + "</h3>");
                    $("#table_weather").children().remove();
                    $("#table_weather").append(table_weather);
                }
            }
        });
    }

    </script>
</body>
</html>
