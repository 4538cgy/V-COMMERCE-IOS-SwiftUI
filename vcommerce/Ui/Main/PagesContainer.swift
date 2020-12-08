//
//  PagesContainer.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/03.
//

import SwiftUI

struct PagesContainer <Content : View> : View {
    @State var index: Int = 0
    @ObservedObject var viewScale : ViewScaleObject
    @GestureState private var translation: CGSize = .zero
    @State var startYGeture : Bool = false
    @State var startYPoint : CGFloat = 0
    let content: Content
    let contentCount: Int
    init(contentCount: Int,viewScale : ViewScaleObject,  @ViewBuilder content: () -> Content) {
        self.contentCount = contentCount
        self.content = content()
        self.viewScale = viewScale
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack (spacing: 0){
                    self.content
                        .frame(width: geometry.size.width)
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.index) * geometry.size.width   )
                .offset(x: self.translation.width)
                .animation(.interactiveSpring())
                .gesture(
                    DragGesture().onChanged({ (value) in
                        if(self.startYGeture == false){
                            startYGeture = true
                            startYPoint = value.translation.height
                        }
                    }).updating(self.$translation) { value, state, _ in
                        state = value.translation // 이것을 통하여 제스처 만큼 이동 됨
                    }.onEnded { value in
                        if(self.startYGeture == true){
                            startYGeture = false
                            if (value.translation.height - self.startYPoint) < -100 { // 하단에서 상단으로 슬라이드
                                if(viewScale.bottomscale == 4){
                                    viewScale.topScale = false
                                }
                                viewScale.bottomscale -= 1
                                if viewScale.bottomscale < 2 {
                                    viewScale.bottomscale = 2
                                }
                                
                            }else if (value.translation.height - self.startYPoint) > 100 { // 상단에서 하단으로 슬라이드
                                if(viewScale.bottomscale == 3){
                                    viewScale.topScale = true
                                }
                                viewScale.bottomscale += 1
                                
                                if viewScale.bottomscale > 4 {
                                    viewScale.bottomscale = 4
                                }
                            }
                        }
                        var weakGesture : CGFloat = 0
                        if value.translation.width < 0 {
                            weakGesture = -100
                        } else {
                            weakGesture = 100
                        }
                        let offset = (value.translation.width + weakGesture) / geometry.size.width
                        let newIndex = (CGFloat(self.index) - offset).rounded()
                        if (newIndex == 4){
                            self.index = 0
                        }else{
                            self.index = min(max(Int(newIndex), 0), self.contentCount - 1)
                        }
                        
                    }
                )
                HStack {
                    ForEach(0..<self.contentCount) { num in
                        Circle().frame(width: 10, height: 10)
                            .foregroundColor(self.index == num ? .primary : Color.secondary.opacity(0.5))
                    }
                }
            }
        }
    }
}
