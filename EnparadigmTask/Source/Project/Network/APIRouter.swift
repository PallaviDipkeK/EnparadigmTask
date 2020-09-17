//
//  APIRequest.swift
//  UniCon
//
//  Created by Ricky on 10/11/19.
//  Copyright © 2019 Rick. All rights reserved.
//

import UIKit

//MARK: BASE API Routes
struct APIRouter {
    
   
    static func Weather_API(selectedCity: String) -> String{
        return "http://api.openweathermap.org/data/2.5/weather?&q=" + "\(selectedCity)" + "&appid=b69ef0e2fb3812990ee504b194852aaf"
    }
}
