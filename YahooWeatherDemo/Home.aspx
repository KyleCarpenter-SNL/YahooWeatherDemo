<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
    <style type="text/css">
        #weatherTable td:nth-child(1)
        {
            width:10%;
        }
        #weatherTable td:nth-child(2)
        {
            width:90%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <label>Type in the city you would like the temperature for and press "GO!"</label>
        <table id="weatherTable" style="width:1000px">
            <tr>
                <td>
                    <input id="city1" type="text" placeholder="City 1" onchange="" />
                </td>
                <td>
                    <div id="temp1"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="city2" type="text" placeholder="City 2" />
                </td>
                <td>
                    <label id="temp2" />
                </td>
            </tr>
            <tr>
                <td>
                    <input id="city3" type="text" placeholder="City 3" />
                </td>
                <td>
                    <label id="temp3" />
                </td>
            </tr>
        </table>
        <input type="button" id="goButton" value="GO!" />
    </form>
    <script>
        $("#goButton").on("click", function()
        {
            for (var i = 1; i < 4; i++)
            {
                getJSON(i);
            }
        })
        function getJSON(i)
        {
            if ($("#city" + i.toString()).val() !== "")
            {
                var city = $("#city" + i.toString()).val();
                var search = "select item.condition from weather.forecast where woeid in (select woeid from geo.places(1) where text='" + city + "')";
                $.ajax({
                    url: "http://query.yahooapis.com/v1/public/yql?q=" + search + "&format=json",
                    type: "GET",
                    dataType: "json",
                    cache: false,
                    success: function (response)
                    {
                        parseJSON(i, city, response)
                    },
                    failure: function (response)
                    {
                        alert(response.d)
                    }
                })
            }
        }
        function parseJSON(i, city, data)
        {
            if (data.query.results !== null)
            {
                var temp = data.query.results.channel.item.condition.temp;
                var cond = data.query.results.channel.item.condition.text;
                $.ajax({
                    type: "POST",
                    url: "Home.aspx/setTXT",
                    data: '{city: "' + city + '", temp: "' + temp + '", cond: "' + cond + '" }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response)
                    {
                        $("#temp" + i.toString()).html(response.d);
                    },
                    failure: function (response)
                    {
                        alert(response.d);
                    }
                });
            }
            else
            {
                $("#temp" + i.toString()).html(city + " is not a valid city name.");
            }
        }
    </script>
</body>
</html>
