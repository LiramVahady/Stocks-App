//
//  CurrencyModel.swift
//  Stocks App
//
//  Created by liram vahadi on 07/02/2021.
//

import Foundation

struct CurrencyModel: Comparable {
    
    let countryCode: String
    let rates: Double
    let symbol: String
    
    static func < (lhs: CurrencyModel, rhs: CurrencyModel) -> Bool {
        return lhs.countryCode < rhs.countryCode
    }
    
}

struct CoinSymbol: Codable {
    
    let symbol: String
}

struct Currency: Codable {
    
    let status, formula: String
    let currencyRates: [String: Double]

       enum CodingKeys: String, CodingKey {
           case status, formula
           case currencyRates = "currency_rates"
       }
}
