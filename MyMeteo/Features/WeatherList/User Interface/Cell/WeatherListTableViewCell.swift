//
//  WeatherListTableViewCell.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 01/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {

    @IBOutlet private(set) weak var cityNameLabel: UILabel! {
        didSet {
            cityNameLabel.text = nil
        }
    }
    @IBOutlet private(set) weak var weatherDescriptionLabel: UILabel! {
        didSet {
            weatherDescriptionLabel.text = nil
        }
    }
    @IBOutlet private(set) weak var weatherIconImageView: UIImageView!
    @IBOutlet private(set) weak var weatherCurrentTemperatureLabel: UILabel! {
        didSet {
            weatherCurrentTemperatureLabel.text = nil
        }
    }
    @IBOutlet private(set) weak var weatherMinMaxTemperatureLabel: UILabel! {
        didSet {
            weatherMinMaxTemperatureLabel.text = nil
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
}
