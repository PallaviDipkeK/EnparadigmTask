//
//  Request.swift
//  UniCon
//
//  Created by Ricky on 10/5/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

//import Alamofire
//import PromiseKit
//import EVReflection


enum NetworkError: Error {
    case badJsonResponse
    case badUrl
    case requestFailedError
    case customError(String)
    
    var localizedDescription: String {
        switch self {
        case .badJsonResponse:
            return "Unexpected values in JSON"
        case .badUrl:
            return "Bad url"
        case .requestFailedError:
            return "Request Failed"
        case .customError(let msg):
            return msg
        }
    }
}


enum NetworkCallType : String{
    case get = "GET"
}

protocol NetworkHandlerDelegate {
    func getRequestBody(requestUrl : URL) -> Data?
}
extension NetworkHandlerDelegate {
    func getRequestHeader(requestUrl: URL) -> [String : String]{
        return ["Content-Type": "application/json"]
    }
 }

public class NetworkHandler: NSObject {

    static let sharedInstance = NetworkHandler()
     var delegate: NetworkHandlerDelegate?
   
    func callNetworkApi(type : NetworkCallType, requestUrlString : String, delegate : NetworkHandlerDelegate, completionBlock: @escaping ( Data?, Bool, String?) -> Void){
        let urlString = requestUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let requestUrl = URL(string: urlString) else { return }
        self.delegate = delegate
        switch type {
        case .get:
            callGetRequest(requestUrl: requestUrl, completionBlock: completionBlock)
         default:
            print("Error: Api Type not hanlded")
        }
    }
    //MARK:- GET Implementation
    
    private func callGetRequest(requestUrl: URL, completionBlock: @escaping ( Data?, Bool, String?) -> Void){
        let urlSession = URLSession(configuration: .default)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = NetworkCallType.get.rawValue
        var header = self.delegate?.getRequestHeader(requestUrl: requestUrl)
        header?["Authorization"] = ""
        request.allHTTPHeaderFields = header
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) -> Void in
            self.handleResponse(data: data, response: response, error: error, requestUrl: requestUrl, completionBlock: completionBlock)
        }
        dataTask.resume()
        
    }
 
    //MARK:- RESPONSE handling implementation
    func handleResponse(data: Data?,response: URLResponse?,error: Error?, requestUrl: URL, completionBlock: @escaping ( Data?, Bool, String?) -> Void){
        if (error != nil) {
            completionBlock(nil, false, error.debugDescription)
        }
        else if  let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 409{
            completionBlock(nil,false,"Error in received Status Code : \(httpResponse.statusCode)")
        }
        else if let httpResponse = response as? HTTPURLResponse, (httpResponse.statusCode != 200 && httpResponse.statusCode != 201){
            completionBlock(data,false,nil)
        }
        else {
            completionBlock(data,true,nil)
        }
    }
}

