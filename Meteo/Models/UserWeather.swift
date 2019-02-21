//
//  UserWeater.swift
//  Meteo
//
//  Created by Jeoffrey Thirot on 18/02/2019.
//  Copyright © 2019 Jeoffrey Thirot. All rights reserved.
//

import UIKit
import CoreLocation

class UserWeather: AbstractModel {
    // MARK: - Variables
    // Private variables
    
    private enum CodingKeys: String, CodingKey {
        case currentLocation
    }
    
    private var _loc: [Location] = []
    private var _weather: [Weather] = []
    
    // Public variables
    
    var currentLocation: Location? // CLLocationCoordinate2D // CLLocation
    var locations: [Location] {
        if let currentLoc = currentLocation {
            var copy = _loc
            copy.insert(currentLoc, at: 0)
            return copy
        }
        return _loc
    }
    
    var currentWeather: Weather?
    var weathers: [Weather] {
        if let currentWea = currentWeather {
            var copy = _weather
            copy.insert(currentWea, at: 0)
            return copy
        }
        return _weather
    }
    
    
    // MARK: - Getter & Setter methods
    
    // MARK: - Constructors
    /**
     Method to create the manager of socket communications
     
     @param settings detail to launch the right sockets connection
     @param delegate used to dispatch event from sockets activities
     */
    override init() {
//        self.currentLocation
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        do {
            try super.init(from: decoder)
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.currentLocation = try? values.decode(Location.self, forKey: .currentLocation)
            
        } catch {
            fatalError("Error! When you want to decode your model: \(AbstractModel.modelName)")
        }
        
        
    }
    
    
    // MARK: - Init behaviors
    
    override func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(currentLocation, forKey: .currentLocation)
            try super.encode(to: encoder)
        } catch {
            fatalError("Error! When you want to encode your model: \(type(of: self).modelName) > \(self)")
        }
    }
    
    
    // MARK: - Public methods
    
    public func add(location: Location) {
        _loc.append(location)
    }
    
    public func removeLocation(at index: Int) {
        _loc.remove(at: index)
    }
    
    // MARK: - Private methods
    
    // MARK: - Delegates methods
}
