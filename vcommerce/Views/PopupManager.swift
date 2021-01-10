//
//  PopupManager.swift
//  vcommerce
//
//  Created by JeongU Park on 2021/01/10.
//

import Foundation
import UIKit
class PopupManger: NSObject {
    private class func loadPopup(_ withId:String) -> BasePopupView! {
        
        let popupView:BasePopupView! = Bundle.main.loadNibNamed("Popup", owner: nil, options: nil)?.filter({
            guard let view = $0 as? UIView else {
                return false
            }
            return (view.restorationIdentifier == withId)
        }).first as? BasePopupView
        
        return popupView
    }
    
    class func alertPopup(title: String, message: String) -> BasePopupView {
        let popup: BasePopupView! = loadPopup("AlertPopupView")
        popup!.titleString = title
        popup!.messageString = message
        return popup!
    }
}

