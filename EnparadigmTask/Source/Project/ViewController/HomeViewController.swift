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
    var selectedCity : String = "Bengaluru"
    var cityList : [String] = ["Bengaluru","Delhi","Pune","Noida"]
    var viewModel: WeatherViewModel? = WeatherViewModel()
    var pickerView = UIPickerView()
    var toolBar = UIToolbar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.getWheatherData(city: selectedCity)
    }
}

extension HomeViewController{
    
    fileprivate func updateData<T>(viewModel: T) {
        if let serverModel = viewModel as? WeatherModel {
            self.locationLabel.text = serverModel.name ?? ""
            self.weatherDescLabel.text = serverModel.weather?.first?.main ?? ""
            self.currentDateLabel.text = self.viewModel?.getCurrentData()
            self.temperatureLabel.text = self.viewModel?.getTempreture()
           self.humidityLabel.text = self.viewModel?.getHumidity()
            self.pressureLabel.text = self.viewModel?.getPressureValue()
            self.windLabel.text = self.viewModel?.getWind()
            self.visibilityLabel.text = self.viewModel?.getVisibity()
        }
        if let localModel = viewModel as? WeatherLocalData {
            self.locationLabel.text = localModel.city ?? ""
            self.weatherDescLabel.text = localModel.weather_Desc ?? ""
            self.currentDateLabel.text = self.viewModel?.getCurrentData()
            self.temperatureLabel.text = self.viewModel?.getTempreture()
            self.humidityLabel.text = self.viewModel?.getHumidity()
            self.pressureLabel.text = self.viewModel?.getPressureValue()
            self.windLabel.text = self.viewModel?.getWind()
            self.visibilityLabel.text = self.viewModel?.getVisibity()
        }
        
    }
    
    func getWheatherData(city: String) {
        if let viewModel = self.viewModel {
            if Reachability.isConnectedToNetwork(){
                viewModel.completionHandler = { (success, error, title, subtitle) in
                    DispatchQueue.main.async {
                        success == true ? self.updateData(viewModel: viewModel.model.self) : self.updateData(viewModel: viewModel.localModel.self)
                    }
                }
                viewModel.getData(city: selectedCity)
            }else{
                let context = LocalDataBaseService.context
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DBMembers.entityName)
                let results = try? context.fetch(fetchRequest)
                let obtainedResults = results as! [NSManagedObject]
                if obtainedResults.first != nil{
                    viewModel.localModel = LocalDataManager.sharedInstance.getValueFromLocal()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.updateData(viewModel: viewModel.localModel)
                    }
                }else{
                    self.showAlert(title: DataAvailablility.title.rawValue, message: DataAvailablility.message.rawValue, preferredStyle: .alert, alertActions: [(AlertAction.retryAction.rawValue, .default)]) { (index) in
                    }
                }
            }
        }
    }
    
    @IBAction func selectCityClicked(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            pickerView = UIPickerView.init()
            pickerView.delegate = self
            pickerView.backgroundColor = UIColor.white
            pickerView.setValue(UIColor.black, forKey: "textColor")
            pickerView.autoresizingMask = .flexibleWidth
            pickerView.contentMode = .center
            pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
            self.view.addSubview(pickerView)
            
            toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
            toolBar.barStyle = .black
            toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
            self.view.addSubview(toolBar)
        }else{
            self.showAlert(title: InternetAvailability.title.rawValue, message: InternetAvailability.message.rawValue, preferredStyle: .alert, alertActions: [(AlertAction.okAction.rawValue, .default)]) { (index) in
            }
        }
    }
    
    @objc func onDoneButtonTapped(_ sender: UIButton){
        self.getWheatherData(city: selectedCity)
        toolBar.removeFromSuperview()
        pickerView.removeFromSuperview()
    }
}


//MARK: - Pickerview method
extension HomeViewController : UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCity = cityList[row]
        
    }
}
