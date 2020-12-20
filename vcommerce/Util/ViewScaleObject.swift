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
    @Published var bottomscale : CGFloat = 3 // Bottom 기본 : 3.  확장 : 2 사라짐 :4
    @Published var topScale : Int = 3 // Top 확장 : 1 , 기본 : 2 , 사라짐 : 3
    
    
    func getTopScale() -> CGFloat {
        if topScale == 1 {
            return -300
        }
        else if(topScale == 2 ){
            return -400
        } else  {
            return -600
        }
    }
}
