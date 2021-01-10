//
//  LoginEamilViewController.swift
//  vcommerce
//
//  Created by JeongU Park on 2021/01/02.
//

import Foundation
import UIKit

class LoginEmailViewController : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func loginClick(_ sender: Any) {
        let popup  = PopupManger.alertPopup(title: "비밀번호 오류", message: "비밀번호를 확인해 주세요") as! AlertPopupView
        popup.showPopup()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
