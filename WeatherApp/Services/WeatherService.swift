//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Prabhdeep Singh on 15/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

enum WeatherServicErrors: Error {
    case noData
    case noResponse
    case invalidResponse
    case failedRequest
    case invalidData
    
}

class WeatherService {
    static private let apiKey = "Your_Api_Key"
    
    static func retrieveWeatherData(completion: @escaping (WeatherModel?,WeatherServicErrors?) -> Void,location: Location) {
        //api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinates.latitude)&lon=\(location.coordinates.longitude)&appid=\(apiKey)"
        let serviceUrl = URL(string: url)
        let serviceRequest = URLRequest(url: serviceUrl!)
        print("URL IS \(url)")
        
        URLSession.shared.dataTask(with: serviceRequest) { (data, response, error) in
            
            guard error == nil else {
                print("Some error occured in retrieving weatherd ata \(String(describing: error))")
                completion(nil, .failedRequest)
                return
            }
            
            guard let data = data else {
                print("No data retrieved from server")
                completion(nil, .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable to process response")
                completion(nil,.invalidResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                print("Failure response from server \(response.statusCode)")
                completion(nil, .failedRequest)
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(weather,nil)
            } catch {
                print("Error in decoding")
                completion(nil, .invalidData)
            }
            
            
        }.resume()
        
    }
}
