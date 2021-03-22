//
//  Extension + ActivityIndicator.swift
//  Stocks App
//
//  Created by liram vahadi on 10/02/2021.
//

import UIKit


extension UIActivityIndicatorView{
    
    func setup(_ view: UIView){
        self.style = .large
        self.color = .black
        self.center = view.center
        self.startAnimating()
        view.addSubview(self)
    }
}
