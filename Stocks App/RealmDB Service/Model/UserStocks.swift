//
//  UserStocks.swift
//  Stocks App
//
//  Created by liram vahadi on 21/02/2021.
//

import RealmSwift

@objcMembers class UserStocks: Object{
    
    dynamic var symbol: String?
    dynamic var company: String?
    dynamic var totalPrice = RealmOptional<Double>()
    dynamic var amount = RealmOptional<Int>()
    
    convenience init(symbol: String?, company: String?, totalPrice: Double?, amount: Int?) {
        self.init()
        self.symbol = symbol
        self.company = company
        self.totalPrice.value = totalPrice
        self.amount.value = amount
    }
}
