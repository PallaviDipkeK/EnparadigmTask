//
//  ViewController+Extensions.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 18/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?,preferredStyle: UIAlertController.Style , alertActions: [(title: String?, style: UIAlertAction.Style)], completion:((Int) -> Void)?) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
        for (index, action) in alertActions.enumerated() {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { (_) in
                completion?(index)
            }
            alertController.addAction(alertAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
 
}
