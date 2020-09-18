//
//  NetworkResults.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 18/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import Foundation

enum NetworkResult {
    case success(WeatherModel)
    case failure(statusCode: HTTPStatusCodes, title: String, subTitle: String)
}

enum HTTPStatusCodes: Int, Equatable {
    case success = 200
    case notFound = 404
    case tooManyRequests = 429
    case unAvailable = 503
}
