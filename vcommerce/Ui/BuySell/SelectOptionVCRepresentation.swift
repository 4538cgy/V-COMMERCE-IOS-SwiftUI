//
//  SelectOptionVCRepresentation.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/27.
//

import Foundation
import SwiftUI

struct SelectOptionVCRepresentation : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some SelectOptionViewController {
        UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(withIdentifier: "SelectOptionViewController") as! SelectOptionViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
