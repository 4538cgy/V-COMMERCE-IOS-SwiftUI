//
//  extUIView.swift
//  vcommerce
//
//  Created by JeongU Park on 2021/01/10.
//

import Foundation
import UIKit
extension UIView {

    func addSubview(_ view: UIView!, origin:CGPoint!, size: CGSize! = nil) {
        self.addSubview(view)
        if (nil != origin) {
            view.frame.origin = origin
        }
        if (nil != size) {
            view.frame.size = size
        }
    }
}
