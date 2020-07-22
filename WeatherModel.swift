//
//  WeatherModel.swift
//  Clima
//
//  Created by Priyank Shah on 7/7/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double

    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...299: return "cloud.bolt"
        case 300...399: return "cloud.drizzle"
        case 500...599: return "cloud.rain.fill"
        case 600...699: return "snow"
        case 700...899: return "cloud.fog.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.bolt"
        default: return "Invalid"
        }
    }
}
