//
//  DailyTableViewCell.swift
//  WeatherGift
//
//  Created by Lucas  Pomeroy  on 3/30/20.
//  Copyright © 2020 Lucas Pomeroy. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var dailyWeekdayLabel: UILabel!
    @IBOutlet weak var dailyHighLabel: UILabel!

    @IBOutlet weak var dailySummaryView: UITextView!
    @IBOutlet weak var dailyLowLabel: UILabel!
    
    var dailyWeather: DailyWeather! {
        didSet{
            dailyImageView.image = UIImage(named: dailyWeather.dailyIcon)
            dailyWeekdayLabel.text = dailyWeather.dailyWeekday
            dailyHighLabel.text = "\(dailyWeather.dailyHigh)°"
            dailySummaryView.text = dailyWeather.dailySummary
            dailyLowLabel.text = "\(dailyWeather.dailyLow)°"
        }
    }
}
