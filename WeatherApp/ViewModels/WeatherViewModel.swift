//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Prabhdeep Singh on 15/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

class WeatherViewModel {
    private var weatherModel: WeatherModel?
    var cityName = Box(" ")
    var cityTemperature = Box(" ")
    var weather = Box(" ")
    
    func retrieveWeatherDetails(location: Location) {
        WeatherService.retrieveWeatherData(completion: { (weatherModel, error) in
            if let error = error {
                print("Erorrrr \(error.localizedDescription)")
                return
            }
            print("Weather \(weatherModel?.weather.first?.main)")
            self.cityName.value = weatherModel!.name
            self.cityTemperature.value = "\(weatherModel!.main.temp.rounded())"
            self.weather.value = weatherModel!.weather.first?.main ?? "NA"
        }, location: location)
    }
}
