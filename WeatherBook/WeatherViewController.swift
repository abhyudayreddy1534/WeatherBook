//
//  ViewController.swift
//  WeatherBook
//
//  Created by Sravanthi Chinthireddy on 12/02/24.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var climateImageView: UIImageView!
    @IBOutlet weak var temperatureValueLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
    
//    MARK: Action Methods
    
    @IBAction func currentLocationTapped(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    
//    MARK: Functions:

}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchAndUpdateTemperature(_ sender: Any) {
        searchTextField.text = ""
    }
//    MARK: TextField Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = searchTextField.text {
            weatherManager.fetchWeather(cityName: cityName)
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Please type something."
            return false
        }
        return true
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
//    WeatherManagerDelegate mthods
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.climateImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureValueLabel.attributedText = weather.temperationString
            self.cityLabel.text = weather.cityName.uppercased()
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManager

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            weatherManager.fetchWeather(withLatitude: lat, andLogitude: lng)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
