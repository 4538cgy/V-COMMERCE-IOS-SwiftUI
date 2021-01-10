//
//  ProductVCRepresentation.swift
//  vcommerce
//
//  Created by JeongU Park on 2021/01/10.
//

import Foundation
import SwiftUI

struct ProductVCRepresentation : UIViewControllerRepresentable {
    
    
    func makeUIViewController(context: Context) -> some ProductViewController {
        UIStoryboard(name: "BuySell", bundle: nil).instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
