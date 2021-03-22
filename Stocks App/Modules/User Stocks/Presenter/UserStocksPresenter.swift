//
//  PresenterUserDetails.swift
//  Stocks App
//
//  Created by liram vahadi on 07/02/2021.
//

import RealmSwift
import Foundation

//MARK: Protocol
protocol UserStocksViewDelegate: NSObjectProtocol {
    
    func exchangeCurrency(with newValue: [String:Double])
    func showEmptyViewLoadData()
    func reloadData()
    func errorOccurs(display message: String?)
    func hideUserStocksComponent()
    func reloadUserStocks()
    func navigateToSellStcok()
    func totalProtfolioValue(_ currentValueStock: Double, _ totalProtfolioPrice: Double)
    
}

class UserStocksPresenter{
    
    //MARK: Properties
    private let apiService = ApiService.shared
    private weak var delegate:  UserStocksViewDelegate?
    
    //MARK: CUrrency Model:
    private var currencyModel = [CurrencyModel]()
    private var currencyViewModel = [CurrencyViewModel]()
    private var coinsSymbols = [String: CoinSymbol]()
    private var filterModel = [CurrencyViewModel]()
    private var yahooStocks: YahooStock?
    private var index = 0{
        didSet{
            if index == userStocks.count{
                delegate?.totalProtfolioValue(currentValueStock, totalValueProtfolio)
                delegate?.reloadData()
            }
        }
    }
    var totalValueProtfolio: Double = 0
    var currentValueStock: Double = 0
    
    
    //MARK: RealmDB Properties:
               
    private let realm = RealmService.shared
    private var userStocks: Results<UserStocks>!
    private var selectedItem: UserStocks?
    
    //MARK: LifeCycle
    init(delegate: UserStocksViewDelegate) {
        
        self.delegate = delegate
        fetchApiData()
        fetchUserStocksDataBase()
        fetchCurrentStockPrice()
    }
    
    
    //MARK: Computed Properties:
    var numberOfRows: Int{
        return filterModel.count
    }
    
    var userStocksNumberOfRows: Int{
        return userStocks.count  
    }

    var totalProtfolioStockPrice: Double{
        
        var totalPrice: Double = 0
        userStocks.forEach{ totalPrice = $0.totalPrice.value! }
        
        return totalPrice
    }
    
    //MARK: Functions
  

    private func fetchApiData(){
        
        delegate?.showEmptyViewLoadData()
        apiService.fetchCurrency { [weak self] result in
            switch result{
            case .success(value: let currency):
                self?.mergeCurrencyData(currency: currency)
            case .failure(message: let message):
                self?.delegate?.errorOccurs(display: message)
            }
        }
        
    }
    
    private func mergeCurrencyData(currency: Currency){
        
        loadCurrencySymbols()
        let currencyOrderDictionary = currency.currencyRates.sorted{$0 < $1}
        
        //-> explain for symbolsDictionary: the real structer of symbols is [String: CoinsSymbols] make little complicated to sort it
        var symbolsDictionary = [String:String]() //-> in this structer more easily to sort
        
        for element in coinsSymbols{
            if !symbolsDictionary.contains(where: {$0.key == element.key}) {
                symbolsDictionary[element.key] = element.value.symbol
            }
        }
        
        let symbolsOrderDictionary = symbolsDictionary.sorted{$0 < $1}
        
        for (index, element) in currencyOrderDictionary.enumerated(){
            currencyModel.append(CurrencyModel(countryCode: element.key, rates: element.value, symbol: symbolsOrderDictionary[index].value))
        }
       
        
        initViewModel(currencyModel: currencyModel)
    }
    
    private func loadCurrencySymbols(){
        
        apiService.fetchCoinsSymbol(){ result in
            switch result{
               case .success(value: let coinsSymbols):
            self.coinsSymbols = coinsSymbols
                case .failure(message: let message):
            self.delegate?.errorOccurs(display: message)
            }
        }
        
    }
    
    private func initViewModel(currencyModel: [CurrencyModel]){
        
        currencyViewModel = currencyModel.map{ CurrencyViewModel(currencyModel: $0) }
        filterModel = currencyViewModel
        if userStocks.count == 0{
            delegate?.reloadData()
        }
    }
    
    func performExchangeOnSelectedItem(at index: Int){
        
        let rate = filterModel[index].rate
        let symbol = filterModel[index].symbol
        let userCurrency: [String:Double] = [symbol: rate]
        UserDefaultsManagement.seDefaultCurrency(userCurrency)
        delegate?.exchangeCurrency(with: userCurrency)
        
       
    }
  
    func getCurrencyModel(at index: Int)-> CurrencyViewModel{
        return filterModel[index]
    }
    
    func didUserSearch(text: String){
        
        if !text.isEmpty {
            filterModel = currencyViewModel.filter{$0.codeCountry.lowercased().contains(text.lowercased())}
        }else{
            filterModel = currencyViewModel
        }
        delegate?.reloadData()
    }
    
    
    //MARK: Function for UserStocks DB:
    
    private func fetchUserStocksDataBase(){
        
        userStocks = realm.realm?.objects(UserStocks.self)
        
    }
    
    func getUserStockModel(at index: Int)-> UserStocks?{
        return userStocks[index]
       
    }
    
    func loadStocks(){
        
        userStocks.count == 0 ? delegate?.hideUserStocksComponent() : delegate?.reloadUserStocks()
    }
    
    func sellStockDidSelectedItem(at index: Int){
        
        selectedItem = userStocks[index]
        delegate?.navigateToSellStcok()
    }
    
    func passDataToSellStock()-> (symbol: String, company: String) {
        guard let symbol = selectedItem?.symbol, let company = selectedItem?.company else {return
        ("","") }
        
        return (symbol: symbol, company: company)
    }
    
    
    private func fetchCurrentStockPrice(){
        print("current stock price")
        userStocks.forEach{
            guard let symbol = $0.symbol,
                  let stockAmount = $0.amount.value,
                  let totalPrice = $0.totalPrice.value
            else { return }
            
            if stockAmount != 0 {
               
                apiService.fetchYahooFinanceApiData(with: symbol) { [weak self] result in
                    switch result{
                    case .success(value: let yahooStock):
                        guard let current = yahooStock.financialData?.currentPrice?.raw else { return }
                       
                        self?.currentValueStock += current * Double(stockAmount)
                        
                        self?.totalValueProtfolio += (totalPrice * Double(stockAmount) )
                        self?.index += 1
                        
                    case .failure(message: let message):
                        self?.delegate?.errorOccurs(display: message)
                    }
                }
            }
        }
    }
    
    
    
}
