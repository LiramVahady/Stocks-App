//
//  CurrencyCoinsService.swift
//  Stocks App
//
//  Created by liram vahadi on 07/02/2021.
//

import Foundation

final class ApiService: ApiClient{
    
    static let shared = ApiService()
    
    private init(){}
    
    //MARK: Currency Api Properties
    let urlString = ConstantValues.ApiProperties.currencyUrlString
    let hostPath = ConstantValues.ApiProperties.currencyHostPath
    
    //MARK: Yahoo Finance Api Properties
    var yahooUrlString = ConstantValues.ApiProperties.yahooUrlString
    let yahooHostPath = ConstantValues.ApiProperties.yahooHostPath
    
    
    func fetchCurrency(completion: @escaping (Result<Currency>)->Void){
        fetch(with: urlString, hostPath: hostPath) { results in
            completion(results)
        }
    }
    
    
   func fetchYahooFinanceApiData(with symbol: String, completion: @escaping (Result<YahooStock>)->Void){
    
        let urlString = yahooUrlString.replacingOccurrences(of: "(symbol)", with: symbol)
            fetch(with: urlString, hostPath: yahooHostPath){ results in
            completion(results)
        }
    
    }
    
    func fetchCoinsSymbol(completion: @escaping (Result<[String:CoinSymbol]>)->Void){
        
        fetchLocalJsonData(with: "CurrencyCoins"){ result in
            completion(result)
        }
        
    }
    
    func fetchStocksData(completion: @escaping (Result<Stocks>)-> Void){
        
        fetchLocalJsonData(with: "stocks_names.list"){ result in
            completion(result)
        }
        
    }
    
}
