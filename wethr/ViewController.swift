//
//  ViewController.swift
//  wethr
//
//  Created by Manish Gehani on 9/4/16.
//  Copyright © 2016 Manish Gehani. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var currWeatherImg: UIImageView!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var cloudLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var minLbl: UILabel!
    @IBOutlet weak var maxLbl: UILabel!
    @IBOutlet weak var riseLbl: UILabel!
    @IBOutlet weak var setLbl: UILabel!

    var weather: WeatherDetails!
    
    let locationManager = CLLocationManager()

    
    func updateUI() {
        
        tempLbl.text = "\(weather.currTemp) °C"
        cloudLbl.text = weather.cloudiness
        cityLbl.text = weather.cityName
        windLbl.text = "\(weather.wind) m/s"
        pressureLbl.text = "\(weather.pressure) hps"
        humidityLbl.text = "\(weather.humidity)%"
        minLbl.text = "\(weather.min) °C"
        maxLbl.text = "\(weather.max) °C"
        riseLbl.text = weather.sunrise
        setLbl.text = weather.sunset
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        weather = WeatherDetails(cityName: "London,uk")
        
        weather.downloadWeather { () -> () in
            
            self.updateUI()
        }
    }
}





