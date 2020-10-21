//
//  RoundedBoarderView.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/21.
//

import Foundation
import UIKit

@IBDesignable
class RoundedBoarderView:UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            //clipsToBounds = (cornerRadius > 0) ? true : false
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet { layer.borderWidth = borderWidth }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet { layer.borderColor = borderColor?.cgColor }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if borderWidth > 0 {
            if layer.borderColor != borderColor?.cgColor {
                layer.borderColor = borderColor?.cgColor
            }
        }
    }
    
    public func setRadius(radius:CGFloat!){
        layer.cornerRadius = radius
    }
}
