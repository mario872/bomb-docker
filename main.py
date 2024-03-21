from flask import *
from threading import Timer
from requests import get
import os
import json

weather = {}
geolocation_url = "http://api.openweathermap.org/geo/1.0/zip?zip={0},{1}&appid=" + api_key
weather_url = "https://api.openweathermap.org/data/3.0/onecall?lat={0}&lon={1}&exclude={2}&units=metric&appid=" + api_key

# Lat and Lon for Caringbah, Sydney, NSW, Australia
lat = '-34.0536'
lon = '151.1212'

def get_weather():
    global weather
    
    weather = json.loads(get(weather_url.format(lat, lon, 'hourly,minutely')).text)

    Timer(600.0, get_weather).start()

app = Flask(__name__)

get_weather()

#@app.route('/')
#def index():
#    return render_template('get_location.html')

@app.route('/')#weather')#/<lat>/<lon>')
def weather_func():#lat, lon):
    return render_template('index.html', weather=weather)

@app.route('/location/<zip_code>/<country>')
def get_location(zip_code, country):
    geo = json.loads(get(geolocation_url.format(zip_code, country)).text)
    return redirect('/weather/{0}/{1}'.format(geo['lat'], geo['lon']))

if __name__ == '__main__':
    app.run("0.0.0.0", port=8001, debug=True)