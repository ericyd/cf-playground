var chart;
ready(function() {
    // attach event listener to button
    document.querySelector('.editFile').addEventListener('click', function(e) {
        return replaceWithEditable(updateZip)
    });
    document.querySelector('#zipForm').addEventListener('submit', function(e) {
        e.preventDefault();
        updateZip();
    });

    // Hide Save button
    document.querySelector('.saveFile').style.display = 'none';
    
    // generate empty chart
    // columns will be loaded via ajax
    chart = c3.generate({
        bindto: '#chart',
        data: {
            columns: [],
            // this defines which column name to point to for x-axis data
            x: 'x',
        },
        axis: {
            x: {
                type: 'timeseries',
                tick: {
                    format: '%Y-%m-%d %I:%m %p',
                    count: 5,
                    
                },
                label: {
                    text: 'Time',
                    position: 'outer-middle'
                }
            },
            y: {
                label: {
                    text: 'Temperature (F)',
                    position: 'outer-center'
                }
            }
        },
    });

    getForecast("97205", setForecastResults);
    getWeather("97205", setWeatherResults);
})

function callWeather(zip, cb, method) {
    var zip = zip || "97205";
    document.getElementById('cityName').style.display = "none";
    document.getElementById('spinner').style.display = "inline";
    // decided this was a bit overkill, see /weather/index.cfm
    // document.getElementById('overlay').style.display = "block";
    
    axios.get('/cfcs/weather.cfc', {
        params: {
            returnformat: 'json',
            method: method,
            zip: zip
        }
    })
    .then(cb, handleError)
    .catch(handleError)
}

function getForecast(zip, cb) {
    return callWeather(zip, cb, 'getForecast');
}

function getWeather(zip, cb) {
    return callWeather(zip, cb, 'getCurrentWeather');
}


function setForecastResults(response) {
    var data = response.data;
    var temps = getTemps(data);
    document.getElementById('cityName').innerText = data.city.name + ', ' + data.city.country
    document.getElementById('cityName').style.display = "inline";
    document.getElementById('spinner').style.display = "none";
    
    // update columns
    chart.load({
        columns: getTemps(data),
    });
}

function setWeatherResults(response) {
    var data = response.data;
    document.getElementById('currentWeather').innerText = data.weather[0].main + ', ' + data.main.temp + ' degrees F';
    document.getElementById('cityName').style.display = "inline";
    document.getElementById('spinner').style.display = "none";
}


function getTemps(data) {
    var temp = ['predicted']
    var tempMin = ['low']
    var tempMax = ['high']
    var x = ['x']
    data.list.forEach(function(day) {
        x.push(new Date(day.dt_txt))
        temp.push(day.main.temp);
        tempMin.push(day.main.temp_min);
        tempMax.push(day.main.temp_max);
    })

    // C3 expects an array of arrays, so this is the most convenient return format
    return [
        x,
        temp,
        tempMin,
        tempMax
    ]
}


function updateZip() {
    var zip = document.getElementById('zipCode').value;
    getForecast(zip, function(response) {
        setForecastResults(response);
        replaceWithReadonly();
    });
    getWeather(zip, setWeatherResults);
}