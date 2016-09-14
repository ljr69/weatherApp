//
//  Functions.swift
//  rainyshinycloudy
//
//  Created by Lloyd Roseblade on 16/08/2016.
//  Copyright © 2016 Lloyd Roseblade. All rights reserved.
//

import Foundation

func convertToCelcius(tempToConvert: Double) -> String {
    
    let celcius = round(tempToConvert - 273.15)
    
    return "\(celcius)"
    
}

func convertToFahrenheit(tempToConvert: Double) -> String {
    
    let kelvinToFahrenheitPreDivision = (tempToConvert * (9/5) - 459.67)
    let fahrenheit = round(10 * kelvinToFahrenheitPreDivision / 10)
    
    return "\(fahrenheit)"
    
}

func convertKelvinTemperature(to: String, kelvinTemperature: Double) -> String {
    
    switch to {
    case "celcius":
        let celcius = round(kelvinTemperature - 273.15)
        return "\(celcius)"
    default:
        let kelvinToFahrenheitPreDivision = (kelvinTemperature * (9/5) - 459.67)
        let fahrenheit = round(10 * kelvinToFahrenheitPreDivision / 10)
        return "\(fahrenheit)"
    }
    
}

