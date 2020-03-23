//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Lucas  Pomeroy  on 3/23/20.
//  Copyright © 2020 Lucas Pomeroy. All rights reserved.
//

import Foundation





class WeatherDetail: WeatherLocation{
    
    struct Result: Codable{
        var timezone: String
        var currently: Currently
        var daily: Daily
    }
    
    struct Currently: Codable {
        var temperature: Double
    }
    
    struct Daily: Codable {
        var summary: String
        var icon: String
    }
    
    var timezone = ""
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
     
    func getData(completed: @escaping () -> ()) {
           let coordinates = "\(latitude),\(longitude)"
           let urlString = "\(APIUrls.darkSkyURL)\(APIKeys.darkSkyKey)/\(coordinates)"
           
           guard let url = URL(string: urlString) else{
               print("ERROR making URL")
            completed()
               return
           }
           
           let session = URLSession.shared
           
           let task = session.dataTask(with: url) { (data, response, error) in
               if let error = error{
                   print("Error \(error.localizedDescription)")
               }
               do {
                   
                let result = try JSONDecoder().decode(Result.self, from: data!)
                self.timezone = result.timezone
                self.temperature = Int(result.currently.temperature.rounded())
                self.summary = result.daily.summary
                self.dailyIcon = result.daily.icon
               }catch{
                   print("JSON ERROR: \(error.localizedDescription)")
                   
               }
            completed()
           
               
           }
           task.resume()
       }
}
