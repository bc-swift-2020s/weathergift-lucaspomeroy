//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Lucas  Pomeroy  on 3/22/20.
//  Copyright © 2020 Lucas Pomeroy. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var latitude: Double
    var longitude: Double
    
    init (name: String, latitude: Double, longitude: Double){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
   
}
