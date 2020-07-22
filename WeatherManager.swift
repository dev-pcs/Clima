//
//  WeatherManager.swift
//  Clima
//
//  Created by Priyank Shah on 7/6/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didupdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithWeather(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=imperial&appid=a3d856b5f9a9e5a267b0c23c01b7a29b"
    
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        self.performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, Longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(Longitude)"
        self.performRequest(with: urlString)
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest (with urlString: String)
    {                       //request based on the url(string data type)
        
        
        if let url = URL(string: urlString) {                       //create url
            
            let session = URLSession(configuration: .default)       //create session
            
            let task = session.dataTask(with: url) { (data, response, error) in     //session task
                if error != nil {
                    self.delegate?.didFailWithWeather(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didupdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()                                           //start the task
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
            
        } catch {
            delegate?.didFailWithWeather(error: error)
            return nil
        }
    }
    
    
    
    
}


