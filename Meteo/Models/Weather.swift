//
//  Weather.swift
//  Meteo
//
//  Created by Jeoffrey Thirot on 15/02/2019.
//  Copyright © 2019 Jeoffrey Thirot. All rights reserved.
//

import UIKit

class Weather: Codable, Serializable {
    // MARK: - Variables
    // Private variables
    
    // Public variables
    
    let coord: Coord
    let weather: [WeatherElement]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let id: Int
    let name: String
    let cod: Int
    
    // MARK: - Getter & Setter methods
    
    // MARK: - Constructors
    
    
    init(coord: Coord, weather: [WeatherElement], base: String, main: Main, visibility: Int, wind: Wind, clouds: Clouds, dt: Int, sys: Sys, id: Int, name: String, cod: Int) {
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.id = id
        self.name = name
        self.cod = cod
    }
}
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? newJSONDecoder().decode(Weather.self, from: jsonData)

class Clouds: Codable {
    let all: Int
    
    init(all: Int) {
        self.all = all
    }
}

class Coord: Codable {
    let lon, lat: Int
    
    init(lon: Int, lat: Int) {
        self.lon = lon
        self.lat = lat
    }
}

class Main: Codable {
    let temp: Double
    let pressure, humidity: Int
    let tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    
    init(temp: Double, pressure: Int, humidity: Int, tempMin: Double, tempMax: Double) {
        self.temp = temp
        self.pressure = pressure
        self.humidity = humidity
        self.tempMin = tempMin
        self.tempMax = tempMax
    }
}

class Sys: Codable {
    let type, id: Int
    let message: Double
    let country: String
    let sunrise, sunset: Int
    
    init(type: Int, id: Int, message: Double, country: String, sunrise: Int, sunset: Int) {
        self.type = type
        self.id = id
        self.message = message
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

class WeatherElement: Codable {
    let id: Int
    let main, description, icon: String
    
    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

class Wind: Codable {
    let speed: Double?
    let deg: Int?
    
    init(speed: Double?, deg: Int?) {
        self.speed = speed
        self.deg = deg
    }
}
