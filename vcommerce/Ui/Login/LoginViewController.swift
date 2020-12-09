//
//  LoginViewController.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/21.
//

import Foundation

import UIKit
import GoogleSignIn
import FirebaseAuth

class LoginViewController : UIViewController {
   
    
    @IBOutlet weak var googleLoginBtn: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveTestNotification(_:)), name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
        
    }
    @objc func didRecieveTestNotification(_ notification: Notification) {
        print("Test Notification")
        
     }
    @IBAction func googleLoginClick(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func logout(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
    }
}
