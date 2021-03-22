//
//  ConstantValues.swift
//  Stocks App
//
//  Created by liram vahadi on 05/02/2021.
//

import UIKit


struct ConstantValues {
    
    struct SegueIdentifier {
        
        static let login = "loginSuccess"
        static let logout = "logout"
        static let buyStock = "buyStock"
        static let sellStock = "sellStock"
        
    }
    
    struct ApiProperties {
        
        static let apiKey = "6992ada995mshf150dfb5c680514p1d6373jsn893b7eec1def"
        static let currencyUrlString = "https://currency-value.p.rapidapi.com/global/currency_rates"
        static let currencyHostPath = "currency-value.p.rapidapi.com"
        static let yahooUrlString = "https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/get-detail?symbol=(symbol)&region=US"
        static let yahooHostPath =  "apidojo-yahoo-finance-v1.p.rapidapi.com"
        
    }
    
    struct systemImageNameProtfolioStatus {
        
        static let statusNotEarn = "arrowtriangle.up.fill"
        static let statusLost = "arrowtriangle.down.fill"
        static let statusEarn = "arrowtriangle.up.fill"
    }
   
}
    



