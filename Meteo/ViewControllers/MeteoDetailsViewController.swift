//
//  MeteoDetailsViewController.swift
//  Meteo
//
//  Created by Jeoffrey Thirot on 15/02/2019.
//  Copyright © 2019 Jeoffrey Thirot. All rights reserved.
//

import UIKit
import CocoaLumberjack
import FontAwesome_swift
import Moya

class MeteoDetailsViewController: UIViewController {
    
    // MARK: - Variables
    // Private variables
    
    // Public variables
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var data: Weather?
    
    
    // MARK: - Getter & Setter methods
    
    // MARK: - Constructors
    
    // MARK: - Init behaviors
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let closeImg = UIImage.fontAwesomeIcon(name: .times, style: .solid, textColor: .darkGray, size: CGSize(width: 44, height: 44))
        closeButton.setImage(closeImg, for: .normal)
        
        iconImageView.contentMode = .scaleAspectFit
        backgroundImageView.contentMode = .scaleAspectFill
        
        if let weatherData = data {
            cityLabel.text = weatherData.name
            temperatureLabel.text = "\(weatherData.main.temp)°"
            
            guard let iconName = weatherData.weather.first?.icon else { DDLogError("Need more informations"); return }
            let iconUrl = URL(string: "https://openweathermap.org/img/w/\(iconName).png")
            iconImageView.kf.setImage(with: iconUrl)
            
            guard let keyword = weatherData.weather.first?.main else { DDLogError("Need more informations"); return }
            _findBackgroundImage(for: keyword)
        }
    }
    
    
    // MARK: - Public methods
    
    @IBAction func closeHandler(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Private methods
    
    private func _findBackgroundImage(for keyword: String) {
        // get info for images => https://api.unsplash.com/search/collections?page=1&query=
        let memoryCapacity = 200 * 1024 * 1024 // 200 MB
        let diskCapacity = 50 * 1024 * 1024 // 50 MB
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: NSTemporaryDirectory())
        let urlSessionConf = URLSessionConfiguration.background(withIdentifier: "\(Constants.bundleIdentifier).weather-cache")
        
        let cachePlugin = NetworkDataCachingPlugin(configuration: urlSessionConf, with: cache)
        let provider = MoyaProvider<UnsplashService>(plugins: [cachePlugin])
        provider.rx.request(.search(keyword: keyword)).map(SearchPhoto.self).subscribe { event in
            switch event {
            case let .success(response):
                
                // get an image
                let imageUrl: String?
                if response.results.count > 0 {
                    // get a random image
                    imageUrl = response.results.randomElement()?.urls.full
                } else {
                    imageUrl = response.results.first?.urls.full
                }
                guard let url = imageUrl, let randomBgUrl = URL(string: url) else {
                    DDLogError("No random image finded")
                    return
                }
                
                // load a random image
                self.backgroundImageView.kf.setImage(with: randomBgUrl, options: [.scaleFactor(UIScreen.main.scale),.transition(.fade(1))])
                
            case let .error(error):
                DDLogDebug("Image of current weather error: \(error)")
                print("------------ \(error)")
            }
        }
    }
}
