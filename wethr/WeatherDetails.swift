//
//  WeatherDetails.swift
//  wethr
//
//  Created by Manish Gehani on 9/4/16.
//  Copyright © 2016 Manish Gehani. All rights reserved.
//

import Foundation
import Alamofire

class WeatherDetails {
    
    private var _cityName: String!
    private var _currTemp: String!
    private var _cloudiness: String!
    private var _wind: String!
    private var _pressure: String!
    private var _humidity: String!
    private var _min: String!
    private var _max: String!
    private var _sunrise: String!
    private var _sunset: String!
    private var _weatherUrl: String!
    
    var cityName: String {
        return _cityName
    }
    
    var currTemp: String {
        return _currTemp
    }
    
    var cloudiness: String {
        return _cloudiness
    }
    
    var wind: String {
        return _wind
    }
    
    var pressure: String {
        return _pressure
    }
    
    var humidity: String {
        return _humidity
    }
    
    var min: String {
        return _min
    }
    
    var max: String {
        return _max
    }
    
    var sunrise: String {
        return _sunrise
    }
    
    var sunset: String {
        return _sunset
    }
    
    var weatherUrl: String {
        return _weatherUrl
    }
        
    init(cityName: String) {
        
        self._cityName = cityName
        _weatherUrl = "\(URL_BASE)\(_cityName)\(APP_ID)"
        print(_weatherUrl)
    }
    
    func downloadWeather(completed: DownloadComplete) {
        let url = NSURL(string: _weatherUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Double {
                        let tempC = round((temp * 10) / 10) - 273.5
                        self._currTemp = "\(tempC)"
                    }
                    
                    if let pressure = main["pressure"] as? Int {
                        self._pressure = "\(pressure)"
                    }
                    
                    if let humidity = main["humidity"] as? Int {
                        self._humidity = "\(humidity)"
                    }
                    
                    if let minTemp = main["temp_min"] as? Double {
                        let minTempC = round((minTemp * 10) / 10) - 273.5
                        self._min = "\(minTempC)"
                    }
                    
                    if let maxTemp = main["temp_max"] as? Double {
                        let maxTempC = round((maxTemp * 10) / 10) - 273.5
                        self._max = "\(maxTempC)"
                    }
                    
                    print("Temp:",self._currTemp)
                    print("Pressure:", self._pressure)
                    print("Humidity:", self._humidity)
                    print("Min:", self._min)
                    print("Max:", self._max)
                }
                
                if let cloudDict = dict["weather"] as? [Dictionary<String, AnyObject>] where cloudDict.count > 0 {
                    if let clouds = cloudDict[0]["description"] as? String {
                        self._cloudiness = clouds.capitalizedString
                    }
                    print(self._cloudiness)
                }
                
                if let windy = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let wind = windy["speed"] as? Double {
                        self._wind = "\(wind)"
                    }
                    print("Wind speed:", self._wind)
                }
                
                if let sys = dict["sys"] as? Dictionary<String, AnyObject> {
                    if let sunrise = sys["sunrise"] as? Int {
                        
                        let epocSunriseTime = NSTimeInterval(sunrise)
                        let sunriseDate = NSDate(timeIntervalSince1970: epocSunriseTime)
                        print(sunriseDate)
                        let fullSunriseDateTime: String = "\(sunriseDate)"
                        self._sunrise = fullSunriseDateTime.substringWithRange(fullSunriseDateTime.startIndex.advancedBy(11)..<fullSunriseDateTime.endIndex.advancedBy(-9))
                    }
                    
                    if let sunset = sys["sunset"] as? Int {
                        
                        let epocSunsetTime = NSTimeInterval(sunset)
                        let sunsetDate = NSDate(timeIntervalSince1970: epocSunsetTime)
                        let fullSunsetDateTime: String = "\(sunsetDate)"
                        self._sunset = fullSunsetDateTime.substringWithRange(fullSunsetDateTime.startIndex.advancedBy(11)..<fullSunsetDateTime.endIndex.advancedBy(-9))
                    }
                    
                    print("Sunrise:", self._sunrise)
                    print("Sunset:", self._sunset)
                }
            }
            completed()
        }
    }
}