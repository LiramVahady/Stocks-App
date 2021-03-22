//
//  BuyStockViewController.swift
//  Stocks App
//
//  Created by liram vahadi on 16/02/2021.
//

import UIKit
import RealmSwift

/*/ USE PRESENTER */

enum TradeOptions: String{
    case purchase = "Purchase"
    case sell = "Sell"
}

class TradeStockViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var stocksTableView: UITableView!
    @IBOutlet weak var headerImage: NSLayoutConstraint!
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var performTradeButton: UIButton!
    
    //MARK: Properties:

    var symbol: String!
    var company: String!
    private var amount = 0
    var buttonTitle: String!
    private var stockPrice: Double = 0
    private let apiService = ApiService.shared
    private var yahooStock: YahooStock?
    private let emptyViewDuringLoadData = EmptyViewDuringLoadingData()
    private let activityIndicator = UIActivityIndicatorView()
    private var stockDescription: String?
    private let realmDB = RealmService.shared
    private var userStocks: Results<UserStocks>!
    private var userStock: UserStocks?
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configurePage()
        fetchStockDetails()
        userStocks = realmDB.realm?.objects(UserStocks.self)
        performTradeButton.setTitle(buttonTitle, for: .normal)
        loadUserStocksDetails()
     
    }
    
    
    //MARK: Actions:
   
    @IBAction func tradeTapped(_ sender: Any) {
        
        guard let stockPrice = yahooStock?.price?.regularMarketPrice.raw else { return }
        
        print("stockPrice =\(stockPrice)")
        switch buttonTitle {
        
        case  TradeOptions.purchase.rawValue:
            
            if CurrentBalnce.currentBalance >= stockPrice{
                
                purchaseSuccess(stockPrice)
                appearDialogToUser(title: "Purchase Success", message: " \(symbol ?? "") stock has been purchase")
                
            }else {
                appearDialogToUser(title: "Purchase Failure", message: "Sorry, Your total Balnce less than stock price")
            }
        
        case TradeOptions.sell.rawValue:
          
            if amount != 0{
                sellSuccess(stockPrice)
                appearDialogToUser(title: "Sell Success", message: "\(symbol ?? "") stock has been sell")
            }else{
                appearDialogToUser(title: "Sell Failure", message: "Sorry, You havn't enough stocks for \(symbol ?? "") to sell ")
            }
            
        default:
            print("")
        }
       
    }
    
    
    //MARK: Functions
    private func configurePage(){
       emptyViewDuringLoadData.showEmptyView(with: self, view: view, activitiIndicator: activityIndicator)
        view.backgroundColor = .white
        performTradeButton.layer.cornerRadius = 10
        configureNavigationBar()
        configureImageView()
    }
    
   private func configureNavigationBar(){

        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func configureImageView(){
        
        stockImage.image = UIImage(named: symbol)
    }
    
    private func fetchStockDetails(){
         
        apiService.fetchYahooFinanceApiData(with: symbol) { [weak self]  results in
            switch results{
            case .success(value: let yahooStock):
                self?.yahooModelDidSet(yahooStock: yahooStock)
            case .failure(message: let message):
                self?.appearDialogToUser(title: "Oops", message: message!)
            }
        }
    }

    private func yahooModelDidSet(yahooStock: YahooStock){
        
        if self.yahooStock == nil{
            self.yahooStock = yahooStock
        }
        stocksTableView.reloadData()
        emptyViewDuringLoadData.hideEmptyView(stop: activityIndicator)
        
    }
          
    private func loadUserStocksDetails(){
        
        switch buttonTitle{
        
        case TradeOptions.purchase.rawValue:
            
            if userStocks.count != 0{
                let filter = userStocks.filter{$0.symbol == self.symbol}
                self.amount = filter.first?.amount.value ?? 0
                self.stockPrice = filter.first?.totalPrice.value ?? 0
                
            }
            
        case TradeOptions.sell.rawValue:
            
            let filter =  userStocks.filter{$0.symbol == self.symbol}
            self.amount =  filter.first?.amount.value ?? 0
            self.stockPrice = filter.first?.totalPrice.value ?? 0
            
        default:
            print("")
        }
        
    }
    
    private func purchaseSuccess(_ stockPrice: Double){
        
        amount += 1
        self.stockPrice = stockPrice * Double(amount)
        userStock = UserStocks(symbol: symbol, company: company, totalPrice: self.stockPrice, amount: amount)
        
        let dictionary: [String: Any?] = ["symbol" :userStock?.symbol ,
                                          "company": userStock?.company ,
                                          "totalPrice": userStock?.totalPrice.value,
                                          "amount" : userStock?.amount.value]
        
        for stock in userStocks!{
            if stock.symbol!.contains(userStock!.symbol!){
                realmDB.update(stock, with: dictionary as [String : Any])
                return
            }
        }
        
    
        CurrentBalnce.currentBalance -= stockPrice
        UserDefaultsManagement.updateUserBalance(CurrentBalnce.currentBalance)
        realmDB.create(userStock!)
        
    }
    
    
    private func sellSuccess(_ stockPrice: Double){
        
        amount -= 1
        self.stockPrice -= stockPrice
        userStock = UserStocks(symbol: symbol, company: company, totalPrice: stockPrice, amount: amount)
        
        let dictionary: [String: Any?] = ["symbol" :userStock?.symbol ,
                                          "company": userStock?.company ,
                                          "totalPrice": userStock?.totalPrice.value,
                                          "amount" : userStock?.amount.value]
        
        for stock in userStocks!{
            if stock.symbol!.contains(userStock!.symbol!){
                amount == 0 ? realmDB.delete(stock) : realmDB.update(stock, with: dictionary as [String : Any])
            }
        }
        
       CurrentBalnce.currentBalance += stockPrice
        UserDefaultsManagement.updateUserBalance(CurrentBalnce.currentBalance)
       
        
    }
    
    
}


extension TradeStockViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockDetailsTableViewCell.cellIdentifier) as? StockDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        if let yahoo = yahooStock{
            cell.configureCell(stock: yahoo)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 2
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
