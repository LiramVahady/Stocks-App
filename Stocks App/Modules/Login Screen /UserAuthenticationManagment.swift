//
//  UserDefaultManagment.swift
//  Stocks App
//
//  Created by liram vahadi on 02/02/2021.
//

import Foundation
/*
 TODO: Explain about this class
 */

final class UserAuthenticationManagment{
    
    
   //MARK: Computed Properties:
    var emailkey: String{
        return "emailAuthen"
    }
    
    var passwordKey: String{
    return "passwordAuthen"
    }
    
    //MARK: Functions
    
    
    //Handle in Register Authentication:
    func isValidEmail(_ email: String)->Bool{
        
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    
       func didEmaillExist(_ email: String)->Bool{
        
        if let emailUserDefault = UserDefaults.standard.string(forKey: emailkey){
            if emailUserDefault.contains(email){
                return true
            }
        }
        return false
    }
        
    func isValidCountOfPassword(_ password: String) -> Bool{
        
        if password.count <= 5 {
            return false
        }else{
            return true
        }
    }
    
    func isRepassValid(_ password: String, _ repassword: String)-> Bool {
        
        if !password.contains(repassword){
            return false
        }else{
            return true
        }
    }
    
    func saveUserDetails(email: String, password: String){
        UserDefaults.standard.setValue(email, forKey: emailkey)
        UserDefaults.standard.setValue(password, forKey: passwordKey)
    }
    
    //Handle in Login Authentication:
     func didUserDetailsEquals(_ email: String, _ password: String)->Bool{
        
        guard let emailUserDefault = UserDefaults.standard.string(forKey: emailkey),
              let passwordUserDefault = UserDefaults.standard.string(forKey: passwordKey)  else { return false }
        
        if emailUserDefault.lowercased().contains(email.lowercased()) &&
            passwordUserDefault.lowercased().contains(password.lowercased()){
            return true
        }else{
            return false
        }
    }
    
}
