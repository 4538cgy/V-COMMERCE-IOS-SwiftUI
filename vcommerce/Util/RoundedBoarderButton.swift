//
//  RoundedBoarderButton.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/21.
//

import Foundation
import UIKit

@IBDesignable
class RoundedBoarderButton:UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = (cornerRadius > 0) ? true : false
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet { layer.borderWidth = borderWidth }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            setBgColorForState(self.backgroundColor, forState: UIControl.State())
        }
    }
    
    fileprivate func setBgColorForState(_ color: UIColor?, forState: UIControl.State){
        if color != nil {
            setBackgroundImage(UIImage.imageWithColor(color!), for: forState)
            
        } else {
            setBackgroundImage(nil, for: forState)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if borderWidth > 0 {
            if state == UIControl.State() && layer.borderColor != borderColor?.cgColor {
                layer.borderColor = borderColor?.cgColor
            }
        }
    }
    
    /*
     override func drawRect(rect: CGRect) {
     let fillColor = UIColor.whiteColor
     
     let context = UIGraphicsGetCurrentContext()
     var myFrame = self.bounds
     CGContextSetLineWidth(context, CGFloat(borderWidth))
     CGRectInset(myFrame, 5, 5)
     fillColor.set()
     UIRectFrame(myFrame)
     }
     
     override func prepareForInterfaceBuilder() {
     var fillColor = borderColor
     if (nil == fillColor || fillColor == UIColor.clearColor()) {
     fillColor = UIColor.whiteColor
     }
     let context = UIGraphicsGetCurrentContext()
     let myFrame = self.bounds
     CGContextSetLineWidth(context, CGFloat(borderWidth))
     CGRectInset(myFrame, 5, 5)
     fillColor!.set()
     UIRectFrame(myFrame)
     }*/
    
}

//Extension Required by RoundedButton to create UIImage from UIColor
extension UIImage {
    class func imageWithColor(_ color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 1.0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

