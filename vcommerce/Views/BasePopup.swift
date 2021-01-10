//
//  BasePopup.swift
//  vcommerce
//
//  Created by JeongU Park on 2021/01/10.
//

import Foundation
import UIKit
class BasePopupView : UIView {
    
    @IBOutlet var contentView : UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messagetLabel: UILabel!
    
    var titleString : String!
    var messageString : String!
    
    func showPopup(){
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            let screenFrame = window.frame
            window.addSubview(self, origin: CGPoint.zero, size: screenFrame.size)
            
            
            //            if let size = UIApplication.shared.delegate?.window!?.frame.size {
            //                self.frame.size = CGSize(width : size.width, height: size.height)
            //            }
            setText()
        }
        
    }
    func hidePopup(){
        
        self.removeFromSuperview()
    }
    func setText(){
        titleLabel.text = titleString
        messagetLabel.text = messageString
    }
    
}


class AlertPopupView : BasePopupView {
    
    @IBOutlet weak var confimBtn: UIButton!

    
    
    @IBAction func confirmClick(_ sender: UIButton) {
        hidePopup()
    }
    
}
