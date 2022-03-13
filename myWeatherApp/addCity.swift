//
//  addCity.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 13.03.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alertAddCity(name: String, placeholder: String, completion: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertDone = UIAlertAction(title: "Добавить", style: .default) { (action) in
            
            let text = alertController.textFields?.first
            guard let text = text?.text else { return }
            completion(text)
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { (_) in }
        
        alertController.addAction(alertDone)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
