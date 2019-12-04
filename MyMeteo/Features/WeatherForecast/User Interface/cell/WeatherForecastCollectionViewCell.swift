//
//  WeatherForecastCollectionViewCell.swift
//  MyMeteo
//
//  Created by Sami Benmakhlouf on 02/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

class WeatherForecastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var meteoImageView: UIImageView!
    @IBOutlet weak var minMaxWeatherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
