//
//  Extension+UIViewController.swift
//  iDEASTTest-iOs
//
//  Created by Admin on 27.04.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, and message: String, buttonTitle: String ,actionHandler: VoidClosure? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: {_ in
            alertController.dismiss(animated: true, completion: nil)
            actionHandler?()
        })
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    func showAlertWithCancel(with title: String, and message: String, buttonTitle: String, cancelHandler: VoidClosure? = nil, actionHandler: VoidClosure? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: {_ in
            alertController.dismiss(animated: true, completion: nil)
            actionHandler?()
        })
        let cancelButtonText = "Cancel"
        let cancelAction = UIAlertAction(title: cancelButtonText, style: .default, handler: {_ in
            alertController.dismiss(animated: true, completion: nil)
            cancelHandler?()
        })
        alertController.addAction(action)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
