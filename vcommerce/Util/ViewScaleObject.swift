//
//  File.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/04.
//

import Foundation
import Combine
import SwiftUI

class ViewScaleObject : ObservableObject {
    @Published var bottomscale : CGFloat = 3
    @Published var topScale : Bool = false
    func update(){
        bottomscale -= 1
        if bottomscale == 0 {
            bottomscale = 3
        }
    }
}
