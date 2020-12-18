//
//  MaterialTextField.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/02.
//
import Foundation
import UIKit
import SwiftUI
import MaterialComponents.MaterialTextFields

struct CustomTextField: UIViewRepresentable{
    var placeholder : String!
    init(placeholder : String) {
        self.placeholder = placeholder
    }
    func makeUIView(context: Context) -> MDCMultilineTextField {
        return  MyMultilineTextField(placeholder: self.placeholder)
    }
    
    func updateUIView(_ uiView: MDCMultilineTextField, context: Context) {
        print("\(uiView.text ?? "Empty")")
    }
    
}
class MyMultilineTextField: MDCMultilineTextField {
    private var controller: MDCTextInputControllerUnderline?
    private var placeholderText: String

    init(placeholder: String) {
        self.placeholderText = placeholder
        super.init(frame: .zero)
//        textfield = UITextField(frame: self.bounds)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialize() {
//        translatesAutoresizingMaskIntoConstraints = false
//        clearButtonMode = .whileEditing

        controller = MDCTextInputControllerUnderline(textInput: self)
        controller?.placeholderText = placeholderText
        
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
