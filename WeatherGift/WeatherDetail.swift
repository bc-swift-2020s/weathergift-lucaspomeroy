//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Lucas  Pomeroy  on 3/23/20.
//  Copyright © 2020 Lucas Pomeroy. All rights reserved.
//

import Foundation

private let dateFormatter: DateFormatter = {
    print("I just created a date formatter")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter
    
}()

private let hourlyFormatter: DateFormatter = {
    print("I just created a date formatter")
    let hourlyFormatter = DateFormatter()
    hourlyFormatter.dateFormat = "ha"
    return hourlyFormatter
    
}()

struct DailyWeather: Codable {
    var dailyIcon: String
    var dailyWeekday: String
    var dailySummary: String
    var dailyHigh: Int
    var dailyLow: Int
}

struct HourlyWeather: Codable {
    var hour: String
    var hourlyIcon: String
    var hourlyTemperature: Int
    var hourlyPrecipProbability: Int
}

class WeatherDetail: WeatherLocation{
    
    private struct Result: Codable{
        var timezone: String
        var currently: Currently
        var daily: Daily
        var hourly: Hourly
    }
    
    private struct Currently: Codable {
        var temperature: Double
        var time: TimeInterval
    }
    
    private struct Daily: Codable {
        var summary: String
        var icon: String
        var data: [DailyData]
    }
    
    private struct DailyData: Codable{
        var icon: String
        var time: TimeInterval
        var summary: String
        var temperatureHigh: Double
        var temperatureLow: Double
    }
    
    private struct Hourly: Codable{
        var data: [HourlyData]
    }
    
    private struct HourlyData: Codable{
        var time: TimeInterval
        var icon: String
        var precipProbability: Double
        var temperature: Double
        
    }
    
    var timezone = ""
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    var dailyWeatherData: [DailyWeather] = []
    var hourlyWeatherData: [HourlyWeather] = []
     
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
                self.currentTime = result.currently.time
                self.temperature = Int(result.currently.temperature.rounded())
                self.summary = result.daily.summary
                self.dailyIcon = result.daily.icon
                for index in 0..<result.daily.data.count{
                    let weekdayDate = Date(timeIntervalSince1970: result.daily.data[index].time)
                    dateFormatter.timeZone = TimeZone(identifier: result.timezone)
                    let dailyWeekday = dateFormatter.string(from: weekdayDate)
                    let dailyIcon = result.daily.data[index].icon
                    let dailySummary = result.daily.data[index].summary
                    let dailyHigh = Int(result.daily.data[index].temperatureHigh.rounded())
                    let dailyLow = Int(result.daily.data[index].temperatureLow.rounded())
                    let dailyWeather = DailyWeather(dailyIcon: dailyIcon, dailyWeekday: dailyWeekday, dailySummary: dailySummary, dailyHigh: dailyHigh, dailyLow: dailyLow)
                    self.dailyWeatherData.append(dailyWeather)
                    
                }
                let lastHour = min(24, result.hourly.data.count)
                for index in 0..<lastHour{
                    let hourlyDate = Date(timeIntervalSince1970: result.hourly.data[index].time)
                    hourlyFormatter.timeZone = TimeZone(identifier: result.timezone)
                    let hour = hourlyFormatter.string(from: hourlyDate)
                    let hourlyIcon = result.hourly.data[index].icon
                    let hourlyPrecipProbability = Int((result.hourly.data[index].precipProbability*100).rounded())
                    let hourlyTemperature = Int(result.hourly.data[index].temperature.rounded())
                    let hourlyWeather = HourlyWeather(hour: hour, hourlyIcon: hourlyIcon, hourlyTemperature: hourlyTemperature, hourlyPrecipProbability: hourlyPrecipProbability)
                    self.hourlyWeatherData.append(hourlyWeather)
                    
                }
               }catch{
                   print("JSON ERROR: \(error.localizedDescription)")
                   
               }
            completed()
           
               
           }
           task.resume()
       }
}
