//
//  HomeViewController.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 17/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
//    @IBOutlet weak var weatherDescLabel: UILabel!
    
    var selectedCity : String = "delhi"
    var viewModel: WeatherViewModel? = WeatherViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
       self.getWheatherData(city: selectedCity)
    }
   // http://openweathermap.org/img/w/50d.png
}

extension HomeViewController{
    fileprivate func updateData(viewModel: WeatherModel?) {
        DispatchQueue.main.async {
            self.locationLabel.text = viewModel?.name ?? ""
            self.currentDateLabel.text = "Today, " +  self.getCurrentData()
            self.temperatureLabel.text = self.viewModel?.getTempreture()
            self.weatherDescLabel.text = viewModel?.weather?.first?.main ?? ""
        }
    }
    
    func getWheatherData(city: String) {
        if let viewModel = self.viewModel {
            viewModel.completionHandler = { (success, error, title, subtitle) in
                if success {
                    self.updateData(viewModel: viewModel.model)
                }else{
                    self.showAlert(title: title, message: subtitle, preferredStyle: .alert, alertActions: [(AlertAction.retryAction.rawValue, .default)]) { (index) in
                    }
                }
            }
            viewModel.getData(city: selectedCity)
        }
    }
    
}
//such as wind, pressure, humidity, etc.
//"temp": 310.69,
//      "feels_like": 313.09,
//      "temp_min": 310.15,
//      "temp_max": 311.15,
//      "pressure": 1001,
//      "humidity": 42
