//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Prabhdeep Singh on 15/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    var coord: Dictionary<String,Double>
    var main: Main
    var name: String
    var weather: Array<Weather>
}

struct Main: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
}

struct Weather: Codable {
    var id: Double
    var main: String
    var description: String
    var icon: String
}

//{"coord": { "lon": 139,"lat": 35},
//  "weather": [
//    {
//      "id": 800,
//      "main": "Clear",
//      "description": "clear sky",
//      "icon": "01n"
//    }
//  ],
//  "base": "stations",
//  "main": {
//    "temp": 281.52,
//    "feels_like": 278.99,
//    "temp_min": 280.15,
//    "temp_max": 283.71,
//    "pressure": 1016,
//    "humidity": 93
//  },
//  "wind": {
//    "speed": 0.47,
//    "deg": 107.538
//  },
//  "clouds": {
//    "all": 2
//  },
//  "dt": 1560350192,
//  "sys": {
//    "type": 3,
//    "id": 2019346,
//    "message": 0.0065,
//    "country": "JP",
//    "sunrise": 1560281377,
//    "sunset": 1560333478
//  },
//  "timezone": 32400,
//  "id": 1851632,
//  "name": "Shuzenji",
//  "cod": 200
//}
