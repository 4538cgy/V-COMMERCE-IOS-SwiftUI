//
//  CartVCRepresentation.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/18.
//

import Foundation
import SwiftUI
struct CartVCRepresentation : UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some CartViewController {
        UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
