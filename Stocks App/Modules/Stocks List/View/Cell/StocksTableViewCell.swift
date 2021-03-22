//
//  StocksTableViewCell.swift
//  Stocks App
//
//  Created by liram vahadi on 12/02/2021.
//

import UIKit

class StocksTableViewCell: UITableViewCell{
    
    static let identifierCell = "stockCell"
    //MARK: Outlets
    @IBOutlet weak var symbolStockLabel: UILabel!
    @IBOutlet weak var companyStockLabel: UILabel!
   
    
    
    func configureCell(model: StockProperties){
        symbolStockLabel.text =  "Symbol: \(model.symbol)"
        companyStockLabel.text = "Company: \(model.company)"
    }
    
    
}
