//
//  Extenssion + UILabel.swift
//  Stocks App
//
//  Created by liram vahadi on 01/03/2021.
//

import UIKit


extension UILabel{
    
    func markPartOfText(text: String, textChange: String, color: UIColor){
        
        let str: NSString = text as NSString
        let range = (str).range(of: textChange)
        let attribute = NSMutableAttributedString.init(string: text)
        attribute.addAttribute(.foregroundColor, value: color, range: range)
        self.attributedText = attribute
        
    }
}
