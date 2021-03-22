//
//  HeaderSectionView.swift
//  Stocks App
//
//  Created by liram vahadi on 15/02/2021.
//

import UIKit

class HeaderSectionView: UITableViewHeaderFooterView{
    
    private var section: Int!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.textColor = .white
        contentView.backgroundColor = UIColor(named: "Color")
    }
    
    func setHeaderViewSection(title: String, section: Int){
        textLabel?.text = title
        self.section = section
    }
    
}
