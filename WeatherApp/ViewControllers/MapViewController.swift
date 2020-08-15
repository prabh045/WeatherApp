//
//  ViewController.swift
//  WeatherApp
//
//  Created by Prabhdeep Singh on 15/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import os.log

class MapViewController: UIViewController{
    
    //MARK: Properties
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var selectedLocation = Location()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        setupLocationdelegate()
    }
    
    //MARK: Actions
    
    @IBAction func mapTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate
//        mapView.addAnnotation(annotation)
        selectedLocation.coordinates = coordinate
        print("tapped on location \(coordinate)")
        
        performSegue(withIdentifier: "showWeather", sender: nil)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeather" {
            if let weatherDetailVc = segue.destination as? WeatherDetailViewController {
                weatherDetailVc.selectedLocation = self.selectedLocation
            }
        }
    }
    
}

//MARK: CoreLocation Extension
extension MapViewController: CLLocationManagerDelegate {
    
    func setupLocationdelegate() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                 locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                 //locationManager.delegate = self
                 locationManager.requestLocation()
                  
            case .denied:
                Alert.showLocationAlert(self)
            default:
                break
            }

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Location detected: %{public}@ ",location.coordinate)
            mapView.setCenter(location.coordinate, animated: true)
            let camera = MKMapCamera(lookingAtCenter: location.coordinate, fromEyeCoordinate: location.coordinate, eyeAltitude: 50_000)
            mapView.setCamera(camera, animated: true)
            selectedLocation.coordinates = location.coordinate
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in determining location \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
             locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
             //locationManager.delegate = self
             locationManager.requestLocation()
            
        case .denied:
            Alert.showLocationAlert(self)
        default:
            break
        }
    }
    
}

