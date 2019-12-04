//
//  WeatherForecastView.swift
//  MyMeteo
//
//
//
//  Created by Sami Benmakhlouf on 02/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import UIKit

class WeatherForecastView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Property
    
    weak var delegate: WeatherForecastViewDelegate?
    
    var presenter: WeatherForecastPresenterInput!
    var imageLoader: ImageLoader!
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public
    
    func viewDidLoad() {
        
        collectionView.register(UINib(nibName: "WeatherForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherForecastCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        presenter.viewDidLoad()
    }
}

// MARK: - UICollectionViewDelegate

extension WeatherForecastView: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension WeatherForecastView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WeatherForecastCollectionViewCell.self),
                                                            for: indexPath) as? WeatherForecastCollectionViewCell else {
                                                                return UICollectionViewCell()
        }
        
        let viewmodel = presenter.viewModelForRowAtIndexPath(indexPath)
        
        
        cell.minMaxWeatherLabel.attributedText = viewmodel.weatherMinMaxTemperature
        cell.minMaxWeatherLabel.adjustsFontSizeToFitWidth = true

        cell.dateLabel.attributedText = viewmodel.date
        
        
        
        imageLoader.loadImage(imageView: cell.meteoImageView, url: viewmodel.weatherIconImageURL, placeholder: viewmodel.weatherIconImagePlaceholder)
        return cell
    }
}

// MARK: - WeatherForecastPresenterOutput

extension WeatherForecastView: WeatherForecastPresenterOutput {
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func displayError(_ params: AlertParamsProtocol) {
      
    }
}
