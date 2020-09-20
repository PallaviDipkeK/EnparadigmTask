//
//  APIManager.swift
//  UniCon
//
//  Created by Ricky on 10/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import Foundation

final class APIManager {

    static let shared = APIManager()
    
    func getWeatherData(city: String, completionHandler: @escaping (NetworkResult) -> Void) {
       
        guard let link = getUrl(city),Reachability.isConnectedToNetwork() else {return completionHandler(NetworkResult.failure(statusCode: HTTPStatusCodes.noInternetAvailble, title: "502", subTitle: "No Network Availble"))}
            
         URLSession.shared.dataTask(with: link) { (data, response, error) in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let httpStatusCode = HTTPStatusCodes(rawValue: statusCode),error == nil{
                switch httpStatusCode {
                case HTTPStatusCodes.success:
                    if let d = data, let obj = try? JSONDecoder().decode(WeatherModel.self, from: d) {
                          completionHandler(NetworkResult.success(obj))
                    }
                case HTTPStatusCodes.tooManyRequests:
                    completionHandler(NetworkResult.failure(statusCode: HTTPStatusCodes.tooManyRequests, title: "429", subTitle: "Too many requests"))
                case HTTPStatusCodes.notFound:
                    completionHandler(NetworkResult.failure(statusCode: HTTPStatusCodes.notFound, title: "404", subTitle: "Not Found"))
                case HTTPStatusCodes.unAvailable:
                    completionHandler(NetworkResult.failure(statusCode: HTTPStatusCodes.unAvailable, title: "503", subTitle: "Un Available"))
                case .noInternetAvailble:
                    completionHandler(NetworkResult.failure(statusCode: HTTPStatusCodes.noInternetAvailble, title: "502", subTitle: "No Nwtwork Availble"))
                }
            }
        }.resume()
    }
    
    fileprivate func getUrl(_ city:String) -> URL? {
      
        let URLString = "\(APIManagerConstant.baseUrl)q=\(city)&appid=\(APIManagerConstant.appkey)"
        
        guard let url = URL(string:URLString) else {
            return nil
        }
        return url
    }
    
}
