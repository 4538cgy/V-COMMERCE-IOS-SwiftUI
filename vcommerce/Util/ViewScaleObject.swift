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
    @Published var topScale : Int = 1 // Top 사라짐 : 1 , 기본 : 2
    @Published var isMainViewStat : Bool = false // false : top | true : bottom
    
    func getTopScale() -> CGFloat {
        if topScale == 2 {
            return -400
        }
        else {
            return -600
        }
    }
    
    func setUpSwipe(){
        topScale -= 1
        if topScale == 1{
            isMainViewStat = false
        }
        if topScale < 1 {
            topScale = 1
        }
        bottomscale -= 1
        if bottomscale < 2 {
            bottomscale = 2
        }
    }
    
    func setDownSwipe(){
        bottomscale += 1
        if bottomscale > 4 {
            bottomscale = 4
        }
        if(bottomscale == 4){
            topScale += 1
            if topScale != 1{
                isMainViewStat = true
            }
            if topScale > 2 {
                topScale = 2
            }
        }
    }
    
}
