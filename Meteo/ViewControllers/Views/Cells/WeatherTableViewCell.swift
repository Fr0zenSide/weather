//
//  WeatherTableViewCell.swift
//  Meteo
//
//  Created by Jeoffrey Thirot on 20/02/2019.
//  Copyright © 2019 Jeoffrey Thirot. All rights reserved.
//

import UIKit
import CocoaLumberjack
import FontAwesome_swift
import Kingfisher

class WeatherTableViewCell: UITableViewCell {
    // MARK: - Variables
    // Private variables
    
    // Public variables
    
    var data: Weather?
    
    // MARK: - Getter & Setter methods
    
    // MARK: - Constructors
    
    // MARK: - Init behaviors
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.imageView?.contentMode = .scaleAspectFit // .scaleAspectFill
    }
    
    // MARK: - Public methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        data = nil
        imageView?.image = UIImage.fontAwesomeIcon(name: .featherAlt, style: .brands, textColor: .lightGray, size: CGSize(width: 80, height: 80))//feather-alt
        textLabel?.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let weatherData = data {
            textLabel?.text = "\(weatherData.main.temp)°"
            
            guard let iconName = data?.weather.first?.icon else { DDLogError("Need more informations"); return }
            _loadImage(with: iconName)
        }
    }
    
    // MARK: - Private methods
    
    private func _loadImage(with iconName: String) {
        let url = URL(string: "https://openweathermap.org/img/w/\(iconName).png")
        imageView?.kf.setImage(with: url)
    }
    
    // MARK: - Delegates methods
}
