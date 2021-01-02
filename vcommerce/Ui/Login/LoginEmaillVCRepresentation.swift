//
//  LoginEmaillVCRepresentation.swift
//  vcommerce
//
//  Created by JeongU Park on 2021/01/02.
//

import Foundation
import SwiftUI
struct LoginEmailVCRepresentation : UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some LoginEmailViewController {
        UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginEmailViewController") as! LoginEmailViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
