//
//  ServerRequest.swift
//  Stocks App
//
//  Created by liram vahadi on 05/02/2021.
//

import Foundation


final class ServerRequest {
    
    static let shared = ServerRequest()
    
    private init(){}
    
    private var seesion = URLSession.shared
    
    func serverRequestwith (urlString: String, header: String) {
        
        guard let url = URL(string: urlString) else {
            print("inalid url path")
            return
        }
        
        let headers = [
            "x-rapidapi-key": ConstantValues.ApiProperties.apiKey,
            "x-rapidapi-host": header
        ]
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = seesion.dataTask(with: request) { data, respone, error in
            DispatchQueue.main.async {
                if error != nil {
                    print(error!)
                }
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    let toString = self.jsonToString(with: jsonObject)
                    print(toString)
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
   
    private func jsonToString(with json: Any)->String{
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let convertToString = String(data: data, encoding: String.Encoding.utf8) ?? ""  as String
            return convertToString
        }catch{
        print(error)
        }
        
        return ""
    }
    
}
