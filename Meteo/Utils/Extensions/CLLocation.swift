//
//  CLLocation.swift
//  Meteo
//
//  Created by Jeoffrey Thirot on 20/02/2019.
//  Copyright © 2019 Jeoffrey Thirot. All rights reserved.
//

import Foundation
import CoreLocation


extension CLLocation: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case altitude
        case horizontalAccuracy
        case verticalAccuracy
        case speed
        case course
        case timestamp
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(altitude, forKey: .altitude)
        try container.encode(horizontalAccuracy, forKey: .horizontalAccuracy)
        try container.encode(verticalAccuracy, forKey: .verticalAccuracy)
        try container.encode(speed, forKey: .speed)
        try container.encode(course, forKey: .course)
        try container.encode(timestamp, forKey: .timestamp)
    }
}

struct Location: Codable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let altitude: CLLocationDistance
    let horizontalAccuracy: CLLocationAccuracy
    let verticalAccuracy: CLLocationAccuracy
    let speed: CLLocationSpeed
    let course: CLLocationDirection
    let timestamp: Date
    
    init(location: CLLocation) {
        latitude            = location.coordinate.latitude
        longitude           = location.coordinate.longitude
        altitude            = location.altitude
        horizontalAccuracy  = location.horizontalAccuracy
        verticalAccuracy    = location.verticalAccuracy
        speed               = location.speed
        course              = location.course
        timestamp           = location.timestamp
    }
}

extension CLLocation {
    convenience init(model: Location) {
        self.init(coordinate: CLLocationCoordinate2DMake(model.latitude, model.longitude),
                  altitude: model.altitude,
                  horizontalAccuracy: model.horizontalAccuracy,
                  verticalAccuracy: model.verticalAccuracy,
                  course: model.course,
                  speed: model.speed,
                  timestamp: model.timestamp)
    }
}
