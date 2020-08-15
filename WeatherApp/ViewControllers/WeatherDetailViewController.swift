//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Prabhdeep Singh on 15/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    
    var selectedLocation = Location()
    var weatherViewModel = WeatherViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("need to show weather detail for \(selectedLocation)")
        weatherViewModel.retrieveWeatherDetails(location: selectedLocation)
        
        weatherViewModel.cityName.bind { (cityName) in
            DispatchQueue.main.async {
                self.cityLabel.text = cityName
            }
            
        }
        
        weatherViewModel.cityTemperature.bind { (temperature) in
            DispatchQueue.main.async {
                self.cityTemperatureLabel.text = "\(temperature)°F"
            }
            
        }
        
        weatherViewModel.weather.bind { (weather) in
            DispatchQueue.main.async {
                switch weather {
                case "Clear":
                    self.weatherImageView.image = UIImage(named: "clear")
                    
                case "Rain":
                    self.weatherImageView.image = UIImage(named: "rain")
                    
                case "Clouds":
                    self.weatherImageView.image = UIImage(named: "clouds")
                    
                case "Thunderstorm":
                     self.weatherImageView.image = UIImage(named: "thunder")
                    
                default:
                    self.weatherImageView.image = UIImage(named: "na")
                }
                
            }
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
