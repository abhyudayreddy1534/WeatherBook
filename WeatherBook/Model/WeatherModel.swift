//
//  WeatherModel.swift
//  WeatherBook
//
//  Created by Sravanthi Chinthireddy on 12/02/24.
//

import Foundation
import UIKit

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperationString: NSAttributedString {
        let tempAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold)];
        let normalAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .regular)]
        
        let temp = NSMutableAttributedString(string: String(format: "%.1f", temperature),
                                      attributes: tempAttributes)
        temp.append(NSAttributedString(string: " °C",
                                            attributes: normalAttributes))
        
        return temp
    }
    
    var conditionName:String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
