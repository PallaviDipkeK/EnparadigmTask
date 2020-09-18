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
       
        guard let link = getUrl(city) else {return}
            
         URLSession.shared.dataTask(with: link) { (data, response, error) in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let httpStatusCode = HTTPStatusCodes(rawValue: statusCode) {
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
