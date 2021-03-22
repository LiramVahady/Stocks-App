//
//  StockDetailsTableViewCell.swift
//  Stocks App
//
//  Created by liram vahadi on 20/02/2021.
//

import UIKit
import WebKit

class StockDetailsTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var phoneDialButton: UIButton!
    @IBOutlet weak var webSiteButton: UIButton!
    @IBOutlet weak var fullTimeEmployeesLabel: UILabel!
    @IBOutlet weak var sectorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
   
    
    //MARK: Properties
    static let cellIdentifier = "detailsCell"
        
    //MARK: Actions:
    
    //Not Able make call in simulator :(
    @IBAction func performDialing(_ sender: Any) {
        makeCall(phoneDialButton.currentTitle!)
    }
    
    @IBAction func showWebSite(_ sender: Any) {
        openBrowser(webSiteButton.currentTitle!)
    }
    
    
    //MARK: Functions
    func configureCell(stock: YahooStock){
       
        stockNameLabel.text = stock.price?.shortName
        addressLabel.text = "Address: \(stock.summaryProfile?.address1 ?? "N/A")"
        cityLabel.text = "City: \(stock.summaryProfile?.city ?? "N/A"), "
        stateLabel.text = " State: \(stock.summaryProfile?.state ?? "N/A")"
        zipLabel.text =  "Zip: \(stock.summaryProfile?.zip ?? "N/A")"
        countryLabel.text = "Cuntry: \(stock.summaryProfile?.country ?? "N/A")"
        phoneDialButton.setTitle("Phone Number: \(stock.summaryProfile?.phone ?? "N/A")", for:.normal)
        webSiteButton.setTitle(stock.summaryProfile?.website, for: .normal)
       
        if let fullTimeEmpliyeesText = stock.summaryProfile?.fullTimeEmployees{
            let fullTimeEmployees = fullTimeEmpliyeesText == 0 ? "None" : "\(fullTimeEmpliyeesText)"
            
            fullTimeEmployeesLabel.text = "Full Time Employees: \(fullTimeEmployees)"
        }
        
        sectorLabel.text = "Sector: \(stock.summaryProfile?.sector ?? "")"
        
        
        
        guard let defaultCurrency = UserDefaultsManagement.loadDefaultCurrency(), let stockPrice = stock.price?.regularMarketPrice.raw else {
            return priceLabel.text = "Price: \(stock.price?.regularMarketPrice.fmt ?? "") $"
        }
        
        let exchangeFormula = stockPrice * defaultCurrency.values.first!
        priceLabel.text = "Price: \(exchangeFormula.currencyFormatter()) \(defaultCurrency.keys.first ?? "") "
       
    }
    
    //MARK: Not Work in Simulator
    private func makeCall(_ phoneNumber: String){
        let correctNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
        if let phoneNumber = URL(string: "tel://\(correctNumber)"), UIApplication.shared.canOpenURL(phoneNumber){
            UIApplication.shared.open(phoneNumber, options: [:], completionHandler: nil)
        }
        
    }
    
   
    private func openBrowser(_ link: String){
        guard let url = URL(string: link) else {return}
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
}
