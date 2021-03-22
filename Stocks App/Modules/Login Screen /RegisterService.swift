//
//  RegisterService.swift
//  Stocks App
//
//  Created by liram vahadi on 09/03/2021.
//

import UIKit

enum AlertOptions: String{
    
    case register
    case login
}

final class RegisterService {
    
    //private init(){}
    private var alertController: UIAlertController?
    private var action: UIAlertAction?
  
    func createUser(with viewControlelr: UIViewController, blurView: UIView ,completion: @escaping (String? ,String?, String?)-> Void){
        
        createAlert(in: viewControlelr, blurView: blurView) { (email, password, repassword) in
            
        guard let email = email, let password = password, let repassword = repassword else {return}
            completion(email, password, repassword)
        }
    }
    
    
    private func createAlert(in viewController: UIViewController, blurView: UIView, completion: @escaping (String? ,String?, String?)-> Void){
        
        alertController = UIAlertController(title: "Register", message: nil, preferredStyle: .alert)
        
        //MARK: @EMAIL
        alertController?.addTextField(configurationHandler: { emailTextField in
            
            emailTextField.placeholder = "Enter Email"
            emailTextField.keyboardType = .emailAddress
            
        })
        
        //MARK: @Password
        alertController?.addTextField(configurationHandler: { passwordTextField in
            
            passwordTextField.placeholder = "Enter password"
            
        })
        
        //MARK: @REPassword
        alertController?.addTextField(configurationHandler: { repasswordTextField in
            
            repasswordTextField.placeholder = "Enter password again"
            
        })
        
        action = UIAlertAction(title: "Ok", style: .default, handler: { action in
            
            var email: String?
            var password: String?
            var repassword: String?
            
            
            if let emailText = self.alertController!.textFields?[0].text{
               email = emailText
            }
            
            if let passwordText = self.alertController?.textFields?[1].text{
                password = passwordText
            }
            
            if let repasswordText = self.alertController?.textFields?[2].text{
                repassword = repasswordText
            }
            
            self.alertController?.removeFromParent()
            completion(email, password, repassword)
            blurView.removeFromSuperview()
        })
        alertController?.addAction(action!)
        viewController.present(alertController!, animated: true, completion: nil)
    }
}
