//
//  WeatherViewModel.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 18/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewModel {
    var model: WeatherModel?
    // MARK: - Properties Initializer
    public var completionHandler: ((Bool, Error?, String?, String?) -> (Void))?
    
    func getData(city: String) {
        APIManager.shared.getWeatherData(city: city) { (result) in
            switch result {
            case let  .failure(_, title, subTitle):
                if let completion = self.completionHandler {
                    completion(false,nil, title, subTitle)
                }
            case let .success(weatherData):
                self.handleData(data: weatherData)
            }
        }
    }
    
    
    private func handleData(data: WeatherModel) {
        if let completion = self.completionHandler {
        model = data
            completion(true,nil, nil, nil)
        }
    }
    
    public func getTempreture() -> String {
        return String(format: "%.0f", (model?.main?.temp ?? 0.0) - 273.15) + "° C"
    }
}
