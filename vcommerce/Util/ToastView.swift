//
//  ToastView.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/22.
//

import Foundation

import UIKit

enum ToastMultiMode : Int {
    case onlyOne
    case replace
}

class ToastView: UIView {
    
    enum Color {
        case black
        case white
    }
    
    static let DURATION_LONG = 5.0
    static let DURATION_SHORT = 2.0
    static let DURATION_VERY_SHORT = 1.0
    
    fileprivate static let DUARTION_FADE = 0.3
    
    fileprivate let margin : CGPoint = CGPoint(x: 15, y: 10)
    
    fileprivate let topMargin : CGPoint = CGPoint(x: 59, y: 70)
    fileprivate var duration : TimeInterval!
    
    fileprivate static var _multiMode : ToastMultiMode = .replace
    static var _toastView : ToastView! = nil

    
    @IBOutlet weak var viewToastContainer: RoundedBoarderView!
    @IBOutlet weak var labelMessage: UILabel!
    
    class func setMultiMode(_ mode:ToastMultiMode) {
        _multiMode = mode
    }
    
    class func show(_ text:String!, duration:TimeInterval = DURATION_LONG, color:Color = Color.black) {
        
        if (nil == text || true == text.isEmpty) { return }
        
        var canGenerate = false
        if _toastView == nil {
            canGenerate = true
        } else {
            if _multiMode == .replace {
                _toastView.hideToast(true)
                canGenerate = true
            }
        }
        
        if canGenerate {
            _toastView = Bundle.main.loadNibNamed("ToastView", owner: nil, options: nil)?.first as! ToastView
            
            if (color == Color.black) {
                _toastView.viewToastContainer.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.6)
                _toastView.labelMessage.textColor = UIColor.white
            }
            else {
                _toastView.viewToastContainer.backgroundColor = UIColor(red:1, green:1, blue:1, alpha: 0.6)
                _toastView.labelMessage.textColor = UIColor.black
            }
            
            _toastView.labelMessage.text = text
            _toastView.duration = duration
            _toastView.showToast()
        }
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        if (nil != newWindow) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
        }
        else {
            NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
        }
    }
    
    @objc func keyboardWillShow(_ sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            recalcLayout(bottomMargin: keyboardSize.height)
        }
    }
    
    @objc func keyboardWillHide() {
        recalcLayout()
    }
    
    
    func recalcLayout(bottomMargin: CGFloat = 0) {
        let window = UIApplication.shared.windows.first
        //let maxFrameWidth = (window?.frame.size.width)! - (topMargin.x * 2)
        //let maxTextWidth = maxFrameWidth - (margin.x * 2)
        //let size = self.labelMessage.text!.sizeWithFont(self.labelMessage.font, width: maxTextWidth)
        let size = self.labelMessage.sizeThatFits()
        let screenHeight = window!.frame.size.height
        let screenWidth = window!.frame.size.width
        let frameWidth = size.width + (margin.x * 2)
        let frameHeight = size.height + (margin.y * 2)
        
        self.viewToastContainer.layer.removeAllAnimations()
        self.viewToastContainer.frame = CGRect(x: (screenWidth / 2) - (frameWidth/2), y: screenHeight - (topMargin.y + frameHeight + bottomMargin), width: frameWidth, height: frameHeight)
        
    }
    
    fileprivate func showToast() {
        if let app = (UIApplication.shared.delegate as? AppDelegate) {
            recalcLayout(bottomMargin: app.keyboardSize.height)
        }
        else {
            recalcLayout()
        }
        
        
        let window = UIApplication.shared.windows.first
        window?.addSubview(self)
        
        self.alpha = 0
        UIView.animate(withDuration: ToastView.DUARTION_FADE, animations: { [weak self] () -> Void in
            self?.alpha = 1
            }, completion: { [weak self] (finished) -> Void in
                self?.perform(#selector(ToastView.hideToast), with: nil, afterDelay: (self?.duration)!)
        })
        
    }
    @objc
    fileprivate func hideToast(_ isNoDelay: Bool = false) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        if isNoDelay {
            self.alpha = 0
            self.removeFromSuperview()
            ToastView._toastView = nil
        } else {
            UIView.animate(withDuration: ToastView.DUARTION_FADE, animations: { [weak self] () -> Void in
                self?.alpha = 0
                }, completion: { [weak self] (finished) -> Void in
                    self?.removeFromSuperview()
                    ToastView._toastView = nil
            })
        }
    }
}
