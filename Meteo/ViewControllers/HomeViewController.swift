//
//  HomeViewController.swift
//  Meteo
//
//  Created by Jeoffrey Thirot on 15/02/2019.
//  Copyright © 2019 Jeoffrey Thirot. All rights reserved.
//

import UIKit
import CocoaLumberjack
import CoreLocation
import Moya
import RxSwift

class HomeViewController: UIViewController {
    // MARK: - Variables
    // Private variables
    
    private var _defaultCellIdentifier = "defaultWeatherCell"
    private var _weatherCellIdentifier = "customWeatherCell"
    
    private var _locationManager = CLLocationManager()
    private var _userInformations: UserWeather!
    private var _selectedLocation: Weather?
    private var _provider: MoyaProvider<WeatherService>!
    private let _refreshControl = UIRefreshControl()
    
    
    // Public variables
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Getter & Setter methods
    
    // MARK: - Constructors
    
    // MARK: - Init behaviors
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the cache configuration for network engine
        let memoryCapacity = 200 * 1024 * 1024 // 200 MB
        let diskCapacity = 50 * 1024 * 1024 // 50 MB
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: NSTemporaryDirectory())
        let urlSessionConf = URLSessionConfiguration.background(withIdentifier: "\(Constants.bundleIdentifier).weather-cache")
        
        let cachePlugin = NetworkDataCachingPlugin(configuration: urlSessionConf, with: cache)
        _provider = MoyaProvider<WeatherService>(plugins: [cachePlugin])
        
        
        // Setup table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add Refresh Control to table view
        if #available(iOS 10.0, *) {
            tableView.refreshControl = _refreshControl
        } else {
            tableView.addSubview(_refreshControl)
        }
        _refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: _refreshControl.tintColor, .kern: 10]
        _refreshControl.attributedTitle = NSAttributedString(string: "Fetching Weather Data ...", attributes: attributes)
        _refreshControl.addTarget(self, action: #selector(_refreshData(_:)), for: .valueChanged)

        
        // Manage data
        _userInformations = UserWeather()
        _determineMyCurrentLocation()
    }
    
    
    // MARK: - Public methods
    
    @IBAction func searchHandler(_ sender: Any) {
        guard let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "searchVC") as? SearchLocationViewController else {
            print("You have a problem here!")
            return
        }
        self.navigationController?.present(searchVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "detailWeatherVC", let detailVC = segue.destination as? MeteoDetailsViewController {
            detailVC.data = _selectedLocation
        }
    }
    
    
    // MARK: - Private methods
    
    private func _determineMyCurrentLocation() {
        _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        _locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            _locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    private func _getCurrentLocationData() {
        guard let lat = _userInformations.currentLocation?.latitude, let long = _userInformations.currentLocation?.longitude else {
            DDLogError("Warning! You don't have enough data to load detail of weather for your current location")
            return
        }
        
        _provider.rx.request(.currentWeather(lat: Int(lat), long: Int(long))).map(Weather.self).subscribe { event in
            switch event {
            case let .success(response):
                DDLogDebug("Weather of current location: \(response)")
                DDLogDebug("\n\n-------------\n\(String(describing: response.dictionary()))\n-------------\n\n")
                self._userInformations.currentWeather = response
                self.tableView.reloadData()
            case let .error(error):
                DDLogDebug("Weather of current location error: \(error)")
            }
        }
    }
    
    @objc private func _refreshData(_ sender: Any) {
        tableView.reloadData()
        self._refreshControl.endRefreshing()
    }
}


// Mark: - Delegate methods
// Mark: - Manage the location of user
extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { DDLogError("Location information missing."); return }
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        manager.stopUpdatingLocation()
        
        let location = Location(location: userLocation)
        _userInformations.currentLocation = location
        // update weather with current Location or if I have made an observer in current location
        _getCurrentLocationData()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DDLogError("CLLocation error \(error)")
    }
}

// Mark: - Manage the tableView delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _userInformations.weathers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentData = _userInformations?.weathers[indexPath.row] else {
            return tableView.dequeueReusableCell(withIdentifier: _defaultCellIdentifier, for: indexPath)
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: _weatherCellIdentifier, for: indexPath) as? WeatherTableViewCell {
            cell.data = currentData
            return cell
        }
        
        // Manage my cell with the default behavior
        return tableView.dequeueReusableCell(withIdentifier: _defaultCellIdentifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentData = _userInformations.weathers[indexPath.row]
        _selectedLocation = currentData
        self.performSegue(withIdentifier: "detailWeatherVC", sender: self)
    }
}
