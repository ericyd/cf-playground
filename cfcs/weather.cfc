component {
    // http://localhost:8888/cfcs/weather.cfc?method=getCurrentWeather&returnformat=json
    remote struct function getCurrentWeather(string zip = "97205") {
        cfhttp(method="GET", charset="utf-8", url="http://api.openweathermap.org/data/2.5/weather", result="result");
        {
            cfhttpparam(name="appid", type="url", value="#application.WEATHER_API_KEY#");
            cfhttpparam(name="zip", type="url", value=zip & ',us');
            cfhttpparam(name="units", type="url", value="imperial");
        };
        return deserializeJSON(result.filecontent);
    };

    remote struct function getForecast(string zip = "97205") {
        cfhttp(method="GET", charset="utf-8", url="http://api.openweathermap.org/data/2.5/forecast", result="result");
        {
            cfhttpparam(name="appid", type="url", value="#application.WEATHER_API_KEY#");
            // use this (q), zip, lat/long, or a few others
            // cfhttpparam(name="q", type="url", value="Portland,usa");
            cfhttpparam(name="zip", type="url", value=zip & ',us');
            cfhttpparam(name="mode", type="url", value="json");
            // imperial = Fahrenheit, metric = celsius, default = kelvin
            cfhttpparam(name="units", type="url", value="imperial");
        };
        return deserializeJSON(result.filecontent);
    };
}
