//
//  LocalDataManager.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 21/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import Foundation
import CoreData

class LocalDataManager{
    static let sharedInstance = LocalDataManager()
    private init() { }
    
    func saveWeatherData(data: WeatherLocalData){
        let context = LocalDataBaseService.context
        let entity = NSEntityDescription.entity(forEntityName: DBMembers.entityName, in: context)
        let currentWeather = NSManagedObject(entity: entity!, insertInto: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DBMembers.entityName)
        let results = try? context.fetch(fetchRequest)
        if results?.count ?? 0 > 1{
            context.delete(currentWeather)
        }
        currentWeather.setValue(data.weather_Desc, forKey: DBMembers.weather_Desc)
        currentWeather.setValue(data.visibility, forKey: DBMembers.visibility)
        currentWeather.setValue(data.temperature, forKey: DBMembers.temperature)
        currentWeather.setValue(data.pressure, forKey: DBMembers.pressure)
        currentWeather.setValue(data.humidity, forKey: DBMembers.humidity)
        currentWeather.setValue(data.city, forKey: DBMembers.city)
        currentWeather.setValue(data.wind, forKey: DBMembers.wind)
        do {
            try context.save()
        }
        catch{
            fatalError("There was an error in saving data")
        }
    }
    func getValueFromLocal() -> WeatherLocalData{
        let context = LocalDataBaseService.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DBMembers.entityName)
        let results = try? context.fetch(fetchRequest)
        let obtainedResults = results as! [NSManagedObject]
        let firstResult = obtainedResults.first
        let weather_Desc = firstResult?.value(forKey: DBMembers.weather_Desc)
        let visibility = firstResult?.value(forKey: DBMembers.visibility)
        let temperature = firstResult?.value(forKey: DBMembers.temperature)
        let pressure = firstResult?.value(forKey: DBMembers.pressure)
        let humidity = firstResult?.value(forKey: DBMembers.humidity)
        let city = firstResult?.value(forKey: DBMembers.city)
        let wind = firstResult?.value(forKey: DBMembers.wind)
        let localModel = WeatherLocalData(humidity: humidity as? Int, city: city as? String, temperature: temperature as? Double, visibility: visibility as? Int, wind: wind as? Double, pressure: pressure as? Int, weather_Desc: weather_Desc as? String)
        return localModel
        
    }
}
