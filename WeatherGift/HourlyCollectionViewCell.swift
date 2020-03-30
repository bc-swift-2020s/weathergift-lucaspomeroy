//
//  HourlyCollectionViewCell.swift
//  WeatherGift
//
//  Created by Lucas  Pomeroy  on 3/30/20.
//  Copyright © 2020 Lucas Pomeroy. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var hourlyTemp: UILabel!
    @IBOutlet weak var hourlyPrecipProb: UILabel!
    @IBOutlet weak var raindropImageView: UIImageView!

    var hourlyWeather: HourlyWeather! {
         didSet{
             
             hourLabel.text = hourlyWeather.hour
            iconImageView.image = getIconImage(iconName: hourlyWeather.hourlyIcon)
             hourlyTemp.text = "\(hourlyWeather.hourlyTemperature)°"
             hourlyPrecipProb.text = "\(hourlyWeather.hourlyPrecipProbability)%"
            if hourlyWeather.hourlyPrecipProbability >= 20{
                hourlyPrecipProb.isHidden = false
                raindropImageView.isHidden = false
            } else{
                hourlyPrecipProb.isHidden = true
                raindropImageView.isHidden = true
            }
         }
     }

    func getIconImage(iconName: String) -> UIImage{
        switch iconName {
            case "clear-day":
                return UIImage(systemName: "sun.max")!
            case "clear-night":
                return UIImage(systemName: "moon")!
            case "rain":
                return UIImage(systemName: "cloud.rain")!
            case "snow":
                return UIImage(systemName: "snow")!
            case "sleet":
                return UIImage(systemName: "cloud.sleet")!
            case "wind":
                return UIImage(systemName: "wind")!
            case "fog":
                return UIImage(systemName: "cloud.fog")!
            case "cloudy":
                return UIImage(systemName: "cloud")!
            case "partly-cloudy-day":
                return UIImage(systemName: "cloud.sun")!
            case "partly-cloudy-night":
                return UIImage(systemName: "cloud.moon")!
        default:
            return UIImage(systemName: "questionmark.diamond")!
            
        }
        
        
        
    }
}



