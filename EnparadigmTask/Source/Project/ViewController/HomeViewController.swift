//
//  HomeViewController.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 17/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  var reqWeatherAPI : WeatherRequestModel = WeatherRequestModel()
    var selectedCity : String = "delhi"
    override func viewDidLoad() {
        super.viewDidLoad()
        reqWeatherAPI.city = selectedCity
        reqWeatherAPI.callGetWeatherAPI { (success, responseModel, message) in
            print("\(success) \(String(describing: responseModel))")
            
        }
    }
    

}

extension HomeViewController{
    
}
