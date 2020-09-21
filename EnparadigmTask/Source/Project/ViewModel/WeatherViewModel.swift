//
//  WeatherViewModel.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 18/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WeatherViewModel {
    var model: WeatherModel?
    var localModel: WeatherLocalData?
    // MARK: - Properties Initializer
    public var completionHandler: ((Bool, Error?, String?, String?) -> (Void))?
    
    func getData(city: String) {
        if Reachability.isConnectedToNetwork() {
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
        } else{
           localModel = LocalDataManager.sharedInstance.getValueFromLocal()
          }
    }
    private func handleData(data: WeatherModel) {
        if let completion = self.completionHandler {
            model = data
            DispatchQueue.main.async {
                let data : WeatherLocalData = WeatherLocalData(humidity: self.model?.main?.humidity ?? 0, city: self.model?.name ?? "", temperature: self.model?.main?.temp ?? 0.0, visibility: self.model?.visibility ?? 0, wind: self.model?.wind?.speed ?? 0.0, pressure: self.model?.main?.pressure ?? 0, weather_Desc: self.model?.weather?.first?.main ?? "")
                LocalDataManager.sharedInstance.saveWeatherData(data: data)
                completion(true,nil, nil, nil)
            }
        }
    }
    func getCurrentData() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return  "Today, " +  formatter.string(from: date)
    }
    
    
    
    func getTempreture() -> String {
        return Reachability.isConnectedToNetwork() == true ? String(format: "%.0f", (model?.main?.temp ?? 0.0) - 273.15) + "° C" : String(format: "%.0f", (localModel?.temperature ?? 0.0) - 273.15) + "° C"
    }
    func getPressureValue() -> String {
        return Reachability.isConnectedToNetwork() == true ? String(model?.main?.pressure ?? 0) + " mb" : String(localModel?.pressure ?? 0) + " mb"
    }
    func getHumidity() -> String {
        return Reachability.isConnectedToNetwork() == true ? String(model?.main?.humidity ?? 0) + " %": String(localModel?.humidity ?? 0) + " %"
    }
    func getVisibity() -> String {
        return Reachability.isConnectedToNetwork() == true ? String((model?.visibility ?? 0) / 1000) + " km" : String((localModel?.visibility ?? 0) / 1000) + " km"
    }
    func getWind() -> String {
        return Reachability.isConnectedToNetwork() == true ? String(Int(model?.wind?.speed ?? 0.0))  + " m/sec" : String(Int(localModel?.wind ?? 0.0))  + " m/sec"
    }
   
}
