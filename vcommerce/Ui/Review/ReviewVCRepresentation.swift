//
//  ReviewVCRepresentation.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/18.
//

import Foundation
import SwiftUI
struct ReviewVCRepresentation : UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some ReviewViewController {
        UIStoryboard(name: "Review", bundle: nil).instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
