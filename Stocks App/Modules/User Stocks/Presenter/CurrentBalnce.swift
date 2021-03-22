//
//  CurrentBalnce.swift
//  Stocks App
//
//  Created by liram vahadi on 22/03/2021.
//

import Foundation

class CurrentBalnce{
    
    static var currentBalance: Double = 100000.00
    
    private init(){}
    
    static func setupUserBalance()-> String{
        
        if let balance = UserDefaultsManagement.userDefault.object(forKey: UserDefaultsManagement.userBalance) as? Double{
            self.currentBalance = balance
        }else {
            currentBalance = 100000.00
        }
        
        
        if let currency = UserDefaultsManagement.loadDefaultCurrency(){
            let exchageFormatter = currentBalance * currency.values.first!
            return "\(exchageFormatter.currencyFormatter()) \(currency.keys.first!)"
        }
        
       
        return "\(currentBalance.currencyFormatter()) $"
        
    }
}
