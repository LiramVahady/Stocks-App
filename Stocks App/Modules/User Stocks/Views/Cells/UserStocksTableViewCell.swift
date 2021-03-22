//
//  UserStocksTableViewCell.swift
//  Stocks App
//
//  Created by liram vahadi on 11/02/2021.
//

import UIKit

class UserStocksTableViewCell: UITableViewCell{
    
    //MARK: @IBOUTLETS

    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    //MARK: Properties
    static let cellIdentifier = "userStocks"
    
    
    func configureCell(userStocks: UserStocks){
        
        let textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        
        let symbol = "Symbol: \(userStocks.symbol ?? "")"
        symbolLabel.markPartOfText(text: symbol, textChange: "Symbol:", color: textColor)
        
        let company =  "Company: \(userStocks.company ?? "") "
        companyLabel.markPartOfText(text: company, textChange: "Company:", color: textColor)
        
        
        if let defaultCurrency = UserDefaultsManagement.loadDefaultCurrency(){
            let exchangeFormula = userStocks.totalPrice.value! * defaultCurrency.values.first!
            let totalPrice = "Total Price: \(exchangeFormula.currencyFormatter()) \(defaultCurrency.keys.first!)"
            totalPriceLabel.markPartOfText(text: totalPrice, textChange: "Total Price:", color: textColor)
            
            
        }else {
             totalPriceLabel.text = "Total Price: \(userStocks.totalPrice.value ?? 0)"
        }
        
        
      
        amountLabel.text =  "Amount: \(userStocks.amount.value!)"
        
        
        /*
        let exchangeFormula = userStocks.totalPrice.value! * defaultCurrency.values.first!
        let totalPrice = "Total Price: \(exchangeFormula.currencyFormatter()) \(defaultCurrency.keys.first!)"
        totalPriceLabel.markPartOfText(text: totalPrice, textChange: "Total Price:", color: textColor)
        
        
        let amount = "Amount: \(userStocks.amount.value ?? 0)"
        amountLabel.markPartOfText(text: amount, textChange: "Amount:", color: textColor)
        */
    }

}
