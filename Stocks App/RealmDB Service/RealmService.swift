//
//  RealmService.swift
//  Stocks App
//
//  Created by liram vahadi on 21/02/2021.
//

import RealmSwift

final class RealmService{
    
    //MARK: Properties
    static let shared = RealmService()
    let realm = try? Realm()
    
    private init(){}
    
    //MARK: Computed Properties
    var tableFilePath: String{
        return Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? ""
    }
    
    
    //MARK: Functions
    func create<T: Object>(_ object: T){
        do{
            try realm?.write{
                realm?.add(object)
                print("object created")
            }
            
        }catch{
            print(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String:Any]){
        do{
            try realm?.write{
                for (key, value) in dictionary{
                    object.setValue(value, forKey: key)
                }
                print("Object Update")
            }
            
        }catch{
            print(error)
        }
    }
    
    func delete<T: Object>(_ object: T){
        do{
            try realm?.write{
                realm?.delete(object)
                print("Object Deleted")
            }
            
        }catch{
            print(error)
        }
    }
    
}
