//
//  StockViewModel.swift
//  Stocks App
//
//  Created by liram vahadi on 16/02/2021.
//

import Foundation

class StockViewModel{
    
    var sectionModel: Section
  
    init(stockModel: Section) {
        self.sectionModel = stockModel
    }
    
    //MARK: Computed Properties
    var industry: String{
        return sectionModel.stockModel.industry
    }
    
    var symbol: String{
        return sectionModel.stockModel.stockDetails.first!.symbol
    }
    
    var company: String{
        return sectionModel.stockModel.stockDetails.first!.company
    }
    
}

