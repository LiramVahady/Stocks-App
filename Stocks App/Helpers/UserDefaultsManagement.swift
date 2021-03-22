//
//  UserDefaultsManagement.swift
//  Stocks App
//
//  Created by liram vahadi on 06/03/2021.
//

import Foundation

final class UserDefaultsManagement{
 
    static let userDefault = UserDefaults.standard
    static let loginSuccess = "loginSuccess"
    static let defaultCurrency = "userCurrencyDefault"
    static let userBalance = "userBalance"
    static let stockPriceKey = "stockPrice"
    static let amountStocks = "amountStocks"
  
    
    //MARK: @Did User Login Already
    static func saveUserSuccessLogin(_ isSuccess: Bool){
        
        userDefault.setValue(isSuccess, forKey: loginSuccess)
    }
    
    static func loadUserLoginSuccess()->Bool{
        
        return userDefault.bool(forKey: loginSuccess)
    }
    
    //MARK: @User currency Defaults
    static func loadDefaultCurrency() -> [String:Double]?{
                
        guard let currencyDefault = userDefault.object(forKey: defaultCurrency) as? [String:Double] else { return nil}
       
        
        return currencyDefault
    }
    
    static func seDefaultCurrency(_ value: [String:Double]){
        
        userDefault.setValue(value, forKey: defaultCurrency)
    }
    
    //MARK: @Update Balance
    static func updateUserBalance(_ value: Double){
        
        userDefault.setValue(value, forKey: userBalance)
    }
    
    static func loadCurrentBalanceValue()->Double?{
        
        return userDefault.object(forKey: userBalance) as? Double
    }
    
        
}
