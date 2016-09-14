//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by Lloyd Roseblade on 16/08/2016.
//  Copyright © 2016 Lloyd Roseblade. All rights reserved.
//

// Step 1 - set up some IBOutlets
// Step 2 - write a function to configure those IBOutlets with our downloaded data

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast: Forecast) {
        
        lowTemp.text = "\(forecast.lowTemp)"
        highTemp.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
    }

}
