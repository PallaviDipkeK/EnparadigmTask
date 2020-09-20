//
//  HomeViewController.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 17/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    
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
       
            self.locationLabel.text = viewModel?.name ?? ""
            self.currentDateLabel.text = self.viewModel?.getCurrentData()
            self.temperatureLabel.text = self.viewModel?.getTempreture()
            self.weatherDescLabel.text = viewModel?.weather?.first?.main ?? ""
            self.pressureLabel.text = self.viewModel?.getCurrentData()
            
            self.humidityLabel.text = self.viewModel?.getHumidity()
            self.pressureLabel.text = self.viewModel?.getPressureValue()
            self.windLabel.text = self.viewModel?.getWind()
            self.visibilityLabel.text = self.viewModel?.getVisibity()
         }
    fileprivate func updateLocalData(viewModel: WeatherLocalData?) {
        self.locationLabel.text = viewModel?.city ?? ""
               self.currentDateLabel.text = self.viewModel?.getCurrentData()
               self.temperatureLabel.text = self.viewModel?.getTempreture()
               self.weatherDescLabel.text = viewModel?.weather_Desc
               self.pressureLabel.text = self.viewModel?.getCurrentData()
               
               self.humidityLabel.text = self.viewModel?.getHumidity()
               self.pressureLabel.text = self.viewModel?.getPressureValue()
               self.windLabel.text = self.viewModel?.getWind()
               self.visibilityLabel.text = self.viewModel?.getVisibity()
             }
    
    func getWheatherData(city: String) {
        if let viewModel = self.viewModel {
            viewModel.completionHandler = { (success, error, title, subtitle) in
                if success {
                     DispatchQueue.main.async {
                 self.updateData(viewModel: viewModel.model)
                    }
                }else{
//                    self.showAlert(title: title, message: subtitle, preferredStyle: .alert, alertActions: [(AlertAction.retryAction.rawValue, .default)]) { (index) in
//                    }
                     DispatchQueue.main.async {
                    self.updateLocalData(viewModel: viewModel.localModel)
                    }
                }
            }
            viewModel.getData(city: selectedCity)
        }
    }

    
   
}
