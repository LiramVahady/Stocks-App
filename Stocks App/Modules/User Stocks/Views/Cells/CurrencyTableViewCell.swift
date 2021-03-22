//
//  CurrencyTableViewCell.swift
//  Stocks App
//
//  Created by liram vahadi on 11/02/2021.
//


import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var codeCountryLabel: UILabel!
    @IBOutlet weak var valueCoinLabel: UILabel!
    @IBOutlet weak var symbolCoinsLabel: UILabel!
    @IBOutlet weak var flagCountryImage: UIImageView!
    
    //MARK: Properties
    static let currencyCellIdetntifier = "currencyCell"

    //MARK: Functions
    func configureCell(with model: CurrencyViewModel){
        
        codeCountryLabel.text = model.codeCountry
        valueCoinLabel.text = "\(String(format: "%.4f", model.rate))"
        symbolCoinsLabel.text = model.symbol
        flagCountryImage.image = UIImage(named: model.codeCountry.lowercased())
        flagCountryImage.layer.cornerRadius = 10
    }
    
}

