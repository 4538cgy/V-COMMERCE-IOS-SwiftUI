//
//  LoginVCRepresentaion.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/21.
//

import Foundation
import SwiftUI
struct LoginVCRepresentation : UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some LoginViewController {
        UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
