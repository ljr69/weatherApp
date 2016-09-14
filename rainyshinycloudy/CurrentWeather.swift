//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Lloyd Roseblade on 07/08/2016.
//  Copyright © 2016 Lloyd Roseblade. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    // add private to declaration and use getters and setters?
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!

    // could this be a guard statement {}?
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        // can we remove self. in _date assignement below?
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {

        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON { response in
            
            let result = response.result

            // the result returns a dictionary of K,V pairs, key is always String, the value can be string,
            // number, array, dict, etc so set to AnyObject
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }
 
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                if let base = dict["main"] as? Dictionary<String, double_t> {
                    if let temp = base["temp"] {
                        self._currentTemp = round(temp - 273.15)
                        print(self._currentTemp)
                    }
                }
 
            }
            
           completed() // to here to avoid race condition
        }
        
        //moved from here
    }
    
}














