//
//  Extension + Double.swift
//  Stocks App
//
//  Created by liram vahadi on 10/02/2021.
//

import Foundation

extension Double{
    
    func currencyFormatter()->String{
        
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .currency
        numberFormatter.positiveFormat = ",#00.00 "
       
        return numberFormatter.string(from: self as NSNumber)!
    }
}
