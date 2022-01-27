//
//  ErrorAlert.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
import UIKit

class ErrorAlert: UIAlertController {
    static func presentError(in viewController: UIViewController, with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alert = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alert)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
