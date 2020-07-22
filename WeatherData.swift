//
//  WeatherData.swift
//  Clima
//
//  Created by Priyank Shah on 7/6/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {      //type alias; envodable and decodable
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id : Int
}



