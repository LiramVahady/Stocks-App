//
//  UserDeailsViewModel.swift
//  Stocks App
//
//  Created by liram vahadi on 07/02/2021.
//

import Foundation

class CurrencyViewModel{
    
    private var currencyModel: CurrencyModel
    
    init(currencyModel: CurrencyModel) {
        self.currencyModel = currencyModel
    }
    
    //MARK: Computed Properties
    var codeCountry: String{
        currencyModel.countryCode
    }
    
    var rate: Double{
        return currencyModel.rates
    }
    
    var symbol: String{
        return currencyModel.symbol
    }
    
}
