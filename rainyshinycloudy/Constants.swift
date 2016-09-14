//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Lloyd Roseblade on 07/08/2016.
//  Copyright © 2016 Lloyd Roseblade. All rights reserved.
//

import Foundation

// URL construction needs a good refactor

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat=\(Location.sharedInstance.latitude)"
let LONGITUDE = "&lon=\(Location.sharedInstance.longitude)"
let APP_ID = "&appid="
let API_KEY = "a89a5e88cfd576cee869d941376adaa5"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=a89a5e88cfd576cee869d941376adaa5"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=a89a5e88cfd576cee869d941376adaa5"



