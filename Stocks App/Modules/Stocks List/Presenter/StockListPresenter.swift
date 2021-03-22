//
//  BuyStocksPresenter.swift
//  Stocks App
//
//  Created by liram vahadi on 16/02/2021.
//

import Foundation

protocol BuyStockViewDelegate: NSObjectProtocol {
    func showEmptyViewLoadData()
    func reloadData()
    func appearErrorDialog(message: String)
    func navigatoToStockDetails()
}

class StockListPresenter {
    
    //MARK: Properties
    private weak var delegate: BuyStockViewDelegate?
    private var stockViewModel = [StockViewModel]()
    private var sectionModel = [Section]()
    private var stocks: Stocks?
    private var selectedStock: StockProperties?
    private var filterStocksViewModel = [StockViewModel]()
    private let apiSetvice = ApiService.shared
    
    //MARK: LifeCycle
    init(delegate: BuyStockViewDelegate) {
    
        self.delegate = delegate
        fetchStocks()
    }
    
    //MARK: Computed Properties
    var numberOfSections: Int{
        return filterStocksViewModel.count
    }
        
    
    //MARK: Functions
    private func fetchStocks(){
        
        apiSetvice.fetchStocksData { [weak self] result in
            switch result{
            case .success(value: let stocks):
                self?.stocks = stocks
                self?.mergeStocksData(stock: stocks)
            case .failure(message: let message):
                self?.delegate?.appearErrorDialog(message: message!)
            }
        }
    }
    
    
    private func mergeStocksData(stock: Stocks){
        
        var dictioanry = [String: [TopStocks]]()
        
        for element in stock.stocks{
            if !dictioanry.contains(where: {$0.key == element.industry}){
                dictioanry[element.industry] = [element]
            }else{
                dictioanry[element.industry]! += [element]
            }
        }
       
        
        for element in dictioanry{
            
           let sorted = element.value.sorted(by: {$0.symbol < $1.symbol})
            sectionModel.append(Section(stockModel: StockModel(industry: element.key, stockDetails: sorted.map{
                StockProperties(symbol: $0.symbol, company: $0.company)
            })))
        }
         
       sectionModel.sort(by: {$0.stockModel.industry < $1.stockModel.industry})
        
        initViewModel(stocks: sectionModel)
     
       
    }
    
    
    private func initViewModel(stocks: [Section]){
       
        stockViewModel = stocks.map{ StockViewModel(stockModel: $0)}
       
        filterStocksViewModel = stockViewModel
        delegate?.reloadData()
    }
    
    func numberOfRowsInSection(_ section: Int)->Int{
        
        return filterStocksViewModel[section].sectionModel.stockModel.stockDetails.count
    }
    
    func getStockModel(_ section: Int, _ indexPath: Int)->StockProperties{
        
        return filterStocksViewModel[section].sectionModel.stockModel.stockDetails[indexPath]
        
    }
    
    
    func getStockIndsturyName(at section: Int)->String{
        return filterStocksViewModel[section].sectionModel.stockModel.industry
    }
    
    func didSelectStock(_ section: Int, _ index: Int){
        selectedStock = filterStocksViewModel[section].sectionModel.stockModel.stockDetails[index]
      
        delegate?.navigatoToStockDetails()
    }
    
    func passDataSelectedItem()-> (symbol: String, company: String){
        
        guard let symbol = selectedStock?.symbol, let company = selectedStock?.company else {return ("","")}
        return (symbol: symbol, company: company)
    }
    
    func searchIndstury(_ text: String){
        if !text.isEmpty{
            filterStocksViewModel = stockViewModel.filter{$0.sectionModel.stockModel.industry.lowercased().contains(text.lowercased())}
        }else{
            filterStocksViewModel = stockViewModel
        }
        
        delegate?.reloadData()
    }
}
