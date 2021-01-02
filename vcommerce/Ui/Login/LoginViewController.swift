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
import FBSDKLoginKit
import SwiftUI

class LoginViewController : UIViewController {
    @IBOutlet weak var googleLoginBtn: UIButton!
    @IBOutlet weak var facebookLoginBtn: FBLoginButton!
    
    // Swift // // Add this to the header of your file, e.g. in ViewController.swift import FBSDKLoginKit // Add this to the body class ViewController: UIViewController { override func viewDidLoad() { super.viewDidLoad() let loginButton = FBLoginButton() loginButton.center = view.center view.addSubview(loginButton) } }

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //viewDidLoad에서 호출 시 splash 와 반복으로 돌아서 문제가 발생
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveTestNotification(_:)), name: Notification.Name(rawValue: "LoginVCAuthUINotification"), object: nil)
        if isLoggedIn() {
            print("LoginVC facebook Login already")
            self.goMain()
        }else{
            print("LoginVC need facebook Login")
        }
    }
    
    func isLoggedIn() -> Bool {
            let accessToken = AccessToken.current
            let isLoggedIn = accessToken != nil && !(accessToken?.isExpired ?? false)
            return isLoggedIn
        }
    func goMain(){
        
        let swiftUIController = UIHostingController(rootView: MainView())
        swiftUIController.modalPresentationStyle = .fullScreen
        self.present(swiftUIController, animated: false, completion: nil)
    }
    @objc func didRecieveTestNotification(_ notification: Notification) {
        print("LoginVC Test Notification")
        self.goMain()
        
     }
    @IBAction func googleLoginClick(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func logout(_ sender: Any) {
        if let token = AccessToken.current, !token.isExpired { // User is logged in, do work such as go to next view controller.
            LoginManager().logOut()
        }
        GIDSignIn.sharedInstance()?.signOut()
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    @IBAction func facebookLogin(_ sender: Any) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if error != nil{
                print(error)
            }else if ((result?.isCancelled) != nil && result?.isCancelled == true) {
                print("facebook login cancled")
            }else{
                print("facebook logined")
                
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                Auth.auth().signIn(with: credential) { (authResult, error) in
                  if let error = error {
                    let authError = error as NSError
                    print("faceBook authError : \(authError)")
                    // ...
                    return
                  }
                    
                    self.goMain()
                  // User is signed in
                  // ...
                }
            }
        }
    }
    
    @IBAction func goLoginEmain(_ sender: UIButton) {
//        performSegue(withIdentifier: "LoginEmailSegue", sender: self)
        let vc = self.storyboard?.instantiateViewController(identifier: "LoginEmailViewController") as! LoginEmailViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "LoginEmailSegue" {
//            //LoginEamilView controller 호출전 준비
//        }
//    }
}
