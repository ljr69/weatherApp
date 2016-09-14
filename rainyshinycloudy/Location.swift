//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Lloyd Roseblade on 17/08/2016.
//  Copyright © 2016 Lloyd Roseblade. All rights reserved.
//

// Create a Singleton class - bloody hell this confused me.
// I didn't even know of a singleton, let alone work out I needed one

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
