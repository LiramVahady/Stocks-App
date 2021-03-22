//
//  ApiClient.swift
//  Stocks App
//
//  Created by liram vahadi on 05/02/2021.
//

import Foundation

enum Result<T>{
    
    case success(value: T)
    case failure(message: String? = nil)
}

protocol ApiClient: class {
    
    var session: URLSession { get }
    func fetch<T: Codable>(with urlString: String, hostPath: String  ,completion: @escaping (Result<T>)->Void)
    func fetchLocalJsonData<T: Codable>(with resource: String, completion: @escaping (Result<T>)->Void)
}

extension ApiClient{
    
    var session: URLSession{
        return URLSession(configuration: .default)
    }
    
    func fetch<T: Codable>(with urlString: String, hostPath: String ,completion: @escaping (Result<T>)->Void){
        if InternetConnectionManager.isConnectedToNetwork(){
            guard let url = URL(string: urlString) else {
                completion(.failure(message: "Invalid Url"))
                return }
            
            let headers = [
                "x-rapidapi-key": ConstantValues.ApiProperties.apiKey,
                "x-rapidapi-host": hostPath
            ]
            
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let task = session.dataTask(with: request){ data, _ , error in
                DispatchQueue.main.async {
                    if error != nil{
                        print(error!)
                        completion(.failure(message: "something went wrong"))
                    }
                    if let data = data{
                        do{
                            let jsonObject = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(value: jsonObject))
                        }catch{
                            print(error)
                            completion(.failure(message: "something went wrong"))
                        }
                    }
                }
            }
            task.resume()
            
        }else{
            completion(.failure(message: "Please Check Your Internet Connection"))
        }
    }
    
    
    func fetchLocalJsonData<T: Codable>(with resource: String, completion: @escaping (Result<T>)->Void){
        do{
            let url = Bundle.main.url(forResource: resource, withExtension: ".json")
            let data = try Data(contentsOf: url!)
            let jsonObject = try JSONDecoder().decode(T.self, from: data)
            completion(.success(value: jsonObject))
        }catch{
            completion(.failure(message: "Fecth Data Failure"))
        }
    }
    
}
