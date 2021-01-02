//
//  SplashViewController.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/26.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth
import FBSDKLoginKit
import SwiftUI

class SplashViewController : UIViewController{
    
    
    override func viewDidLoad(){
        super.viewDidLoad()


        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveLoginNotification(_:)), name: Notification.Name(rawValue: "ToggleAuthLoginNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveNoLoginNotification(_:)), name: Notification.Name(rawValue: "ToggleAuthNotLoginNotification"), object: nil)

    }
    override func viewDidAppear(_ animated: Bool) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
//         Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }

    
    @objc func didRecieveLoginNotification(_ notification: Notification) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "ToggleAuthLoginNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "ToggleAuthNotLoginNotification"), object: nil)
//        print("Login")
        goMain()
    }
    @objc func didRecieveNoLoginNotification(_ notification: Notification) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "ToggleAuthLoginNotification"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "ToggleAuthNotLoginNotification"), object: nil)
//        print("No Login")
        if isLoggedIn() {
//            print("facebook Login already")
            self.goMain()
        }else{
            self.goLogin()
        }
        
    }
    func goLogin(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    func goMain(){
        
        let swiftUIController = UIHostingController(rootView: MainView())
        swiftUIController.modalPresentationStyle = .fullScreen
        self.present(swiftUIController, animated: false, completion: nil)
    }
    func isLoggedIn() -> Bool {
            let accessToken = AccessToken.current
            let isLoggedIn = accessToken != nil && !(accessToken?.isExpired ?? false)
            return isLoggedIn
        }
    @IBAction func testAction(_ sender: UIButton) {
        goLogin()
    }
    
}
