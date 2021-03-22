//
//  Extension + UIView.swift
//  Stocks App
//
//  Created by liram vahadi on 10/02/2021.
//

import UIKit

extension UIViewController{
    
    func keyboardDissmis(){
        
        let keyboardDismissTapped = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        keyboardDismissTapped.cancelsTouchesInView = false
        view.addGestureRecognizer(keyboardDismissTapped)
    }
    
    func appearDialogToUser(title: String,message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
}
