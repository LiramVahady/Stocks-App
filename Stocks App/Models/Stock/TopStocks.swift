//
//  YahooModel.swift
//  Stocks App
//
//  Created by liram vahadi on 14/02/2021.
//

import Foundation

struct StockModel{
    
    let industry: String
    var stockDetails: [StockProperties]
}

struct StockProperties {
   
    let symbol: String
    let company: String
}


struct Stocks: Codable {
    
    let stocks: [TopStocks]
}

struct TopStocks: Codable {
    
    let symbol, company, industry: String

    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case company = "Company"
        case industry
    }
    
}

