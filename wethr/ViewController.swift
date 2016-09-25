//
//  ViewController.swift
//  wethr
//
//  Created by Manish Gehani on 9/4/16.
//  Copyright © 2016 Manish Gehani. All rights reserved.
//

import UIKit
import MapKit
import AddressBookUI

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
//        cityLbl.text = weather.cityName
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
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        weather = WeatherDetails(cityName: "London,uk")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            else if placemarks?.count > 0 {
                let pm = placemarks![0]
                let city = "\(pm.addressDictionary!["City"]!)"
                let spacelessCity = city.stringByReplacingOccurrencesOfString(" ", withString: "%20")
//                let country = pm.addressDictionary!["Country"]!
                self.cityLbl.text = city
                self.weather = WeatherDetails(cityName: spacelessCity)
                self.weather.downloadWeather { () -> () in
                    
                    self.updateUI()
                }
//                self.formatTime("11:42")
            }
        }
    }
    
//    func formatTime(time: String!) {
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "HH:mm"
//        dateFormatter.timeZone = NSTimeZone(name: "GMT")
//        let date = dateFormatter.dateFromString(time)
//        
//        dateFormatter.dateFormat = "HH:mm"
//        dateFormatter.timeZone = NSTimeZone.localTimeZone()
//        print(NSTimeZone.systemTimeZone())
//        let timeStamp = dateFormatter.stringFromDate(date!)
//        print("Time: \(timeStamp)")
//    }
}



