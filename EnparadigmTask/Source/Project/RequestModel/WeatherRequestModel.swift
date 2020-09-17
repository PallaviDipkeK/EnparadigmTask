//
//  WeatherRequestModel.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 17/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import UIKit
class WeatherRequestModel:  NSObject, NetworkHandlerDelegate, Codable {
 var city : String
  enum requestKeys : String, CodingKey{
       case city = "city"
  
    }
   override init() {
       city = ""
  }
   
   required init(from decoder: Decoder) throws{
      let container = try decoder.container(keyedBy: requestKeys.self)
       city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
  }

   func encode(to encoder: Encoder) throws{
       var container = try encoder.container(keyedBy: requestKeys.self)
          try container.encodeIfPresent(city, forKey: .city)
   }

   func getRequestBody(requestUrl: URL) -> Data? {
       do{
           let encoder = JSONEncoder()
           let data = try encoder.encode(self)
           return data
       }catch{
           return nil
       }
    }
    func callGetWeatherAPI(completion: @escaping(Bool,WeatherModel?, String?) -> Void){
        
        NetworkHandler.sharedInstance.callNetworkApi(type: .get, requestUrlString: APIRouter.Weather_API(selectedCity: city), delegate: self) { (data, success, message) in
            if success == true{
                guard let dataInfo = data else {
                    completion(false, nil,nil)
                    return
                }
                let decoder = JSONDecoder()
                do {
                let userResModel = try decoder.decode(WeatherModel.self, from: dataInfo)
                    completion(true, userResModel,nil)
                }
                catch let error {
                    completion(false, nil,error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
            else {
                completion(false, nil, "Something went wrong, please try again.")
            }
        }
        
    }
    
}
