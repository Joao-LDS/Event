//
//  CommonAlert.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import UIKit

class CommonAlert: UIAlertController {
    
    static func createAlert(title: String,
                            message: String,
                            cancelCompletion: @escaping() -> ()) -> UIAlertController {
        
        let alert = self.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel) { _ in
            cancelCompletion()
        })
        return alert
    }
}
