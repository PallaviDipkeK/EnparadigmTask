//
//  Constant.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 18/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import Foundation
/// Storyboard name
struct StoryboardConstant {
   static let main = "Main"
   static let launch = "LaunchScreen"
}

struct APIManagerConstant {
    static let appkey = "b69ef0e2fb3812990ee504b194852aaf"
    static let baseUrl = "http://api.openweathermap.org/data/2.5/weather?"
}

/// Alert Buttons
enum AlertAction: String {
    case okAction = "OK"
    case cancelAction = "Cancel"
    case retryAction = "Retry"

}

enum InternetAvailability: String {
    case title = "Internet"
    case message = "Internet not Avaiable"
}

