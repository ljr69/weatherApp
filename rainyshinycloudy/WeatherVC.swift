//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by Lloyd Roseblade on 05/08/2016.
//  Copyright © 2016 Lloyd Roseblade. All rights reserved.
//

// Note about viewDidLoad vs viewDidAppear
// viewDidLoad is run only once (except in exceptional circumstances) and is for your static, lives forever view.
// viewDidAppear runs every time the view, well, appears - good place for refreshing content.
// you should also use viewDidLoad to place your arrays and controls and viewDidAppear to refresh them (saves potential memory leak scenarios)

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather = CurrentWeather()
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The locationManager is right here in this view controller and so set delegate to 'self'
        // Then set the location accuracy to the best available and told the app to only use the GPS 
        // when it's in use. Finally tell the app when it needs to update based on GPS changes.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()

        // and tell the tableView where the delegate and the data is
        tableView.delegate = self
        tableView.dataSource = self
        
        //
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // runs before the view loads (apparently)
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    // Minimum funcs required to satisfy UITableVieDelegate and UITableViewDataSource are numberOfSections, numberOfRows, and cellForRowAt: IndexPath
    // First two return the number of sections and rows within the sections. The latter is to give an index for reusing the table cells (so it can reuse
    // cells for data being scrolled in)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return 6
        return forecasts.count // returned rows must equal the count of returned data you'll be passing to the tableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
            
        } else {
            return WeatherCell()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        
        // Downloading forecast weather data for tableView (easier to pass in data when placed in the VC that has the TableView in it)
        let forecast_URL = URL(string: FORECAST_URL)
        Alamofire.request(forecast_URL!).responseJSON { response in
            
            let result = response.result
            
            // I found it easier to work from the deepest level up in order to understand how to 'walk' the json object, e.g. {[{}]}
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    // had to remove at index 0 otherwise it displayed today's data in the first weatherCell too
                    self.forecasts.remove(at: 0)
                    // if you don't reload the data after it's been pulled down you'll get empty weatherCells (this stuff is a nightmare)
                    self.tableView.reloadData()
                }
            }
            // when I get to this point I know the json results have been pulled successfully
            completed()
        }
    }
    
    func updateMainUI() {
        
        let fixIt: Double = currentWeather._currentTemp
        
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(fixIt)"
        currentWeatherTypeLabel.text = currentWeather._weatherType
        locationLabel.text = currentWeather._cityName
        currentWeatherImage.image = UIImage(named: currentWeather._weatherType)
        
    }
    
    func locationAuthStatus() {
        // Had to update info.plist to add 'Location - Privacy When In Use' and add the message I wanted to pop up on the screen
        
        // Couldn't use locationManager here as it complains about binary compare (==) and Static members...ooo errr missus
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            let currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation?.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation?.coordinate.longitude
            
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }

        } else {
            
            locationManager.requestWhenInUseAuthorization()
            // lol don't forget to call the func again when we've received authorisation *ahem...cough*
            locationAuthStatus()            
        }
        
    }

}

