//
//  EmptyViewLoadinData.swift
//  Stocks App
//
//  Created by liram vahadi on 16/02/2021.
//

import UIKit

final class EmptyViewDuringLoadingData: UIView {
    
    var emptyView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.01176470588, blue: 0.8274509804, alpha: 1)
        
        return view
    }()
    
    var emptyCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var messageTetx: UILabel = {
        let label = UILabel()
        label.text = "No Stocks Purchase"
        label.textColor = .black
        label.textAlignment = .center
        label.font =  label.font.withSize(26)
        return label
    }()
    
    func showEmptyView(with viewController: UIViewController, view: UIView, activitiIndicator: UIActivityIndicatorView){
        emptyView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        activitiIndicator.setup(emptyView)
        
        view.addSubview(emptyView)
    }
    
    func hideEmptyView(stop activitiIndicator: UIActivityIndicatorView){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.emptyView.alpha = 0.0
        }){ _ in

            self.emptyView.removeFromSuperview()
        }
        
        activitiIndicator.stopAnimating()
    }
    
    func hideCell(_ view: UIView){
        
        emptyCell.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        messageTetx.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        emptyCell.addSubview(messageTetx)
        view.addSubview(emptyCell)
        
    }
    
    func showCell(_ view: UIView){
        
        emptyCell.removeFromSuperview()
    }
    
}
