//
//  MainView.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/02.
//

import SwiftUI
import SwiftUIPager
import AVKit
import Combine

struct MainView: View {
    @State var page: Int = 0
    @ObservedObject var viewScale : ViewScaleObject = ViewScaleObject()
    
    @State var startYGeture : Bool = false
    @State var startYPoint : CGFloat = 0
    var body: some View {
        ZStack{
            PagesContainer(contentCount: 4,viewScale : viewScale) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.green.opacity(0.3))
                            .padding()
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.yellow.opacity(0.3))
                            .padding()
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.red.opacity(0.3))
                            .padding()
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.blue.opacity(0.3))
                            .padding()
                    }
            ZStack{
                topView()
                    .offset(x: 0, y: viewScale.topScale ? -450 : -600)
                    .gesture(DragGesture().onChanged({ (value) in
                        checkStart(height: value.translation.height)
                    }).onEnded({ (value) in
                        checkEndDrageGesture(height: value.translation.height)
                    })).animation(.spring())
                bottomView().offset(x: 0, y: viewScale.bottomscale * 160 ).gesture(DragGesture().onChanged({ (value) in
                    checkStart(height: value.translation.height)
                }).onEnded({ (value) in
                    checkEndDrageGesture(height: value.translation.height)
                })).animation(.easeIn)
            }
        }.contentShape(Rectangle()).gesture(DragGesture().onChanged({ (value) in
            print(" all change value: \(value)")
        }).onEnded({ (value) in

                print("all end value: \(value)")
        }))
        
        
    }
    func checkStart(height : CGFloat){
        if(self.startYGeture == false){
            startYGeture = true
            startYPoint = height
        }
    }
    func checkEndDrageGesture(height : CGFloat){
        if(self.startYGeture == true){
            startYGeture = false
            print("gap : \(height - self.startYPoint)")
            if (height - self.startYPoint) < -100 {
                if(viewScale.bottomscale == 4){
                    viewScale.topScale = false
                }
                viewScale.bottomscale -= 1
                if viewScale.bottomscale < 1 {
                    viewScale.bottomscale = 1
                }
                
            }else if (height - self.startYPoint) > 100 {
                if(viewScale.bottomscale == 3){
                    viewScale.topScale = true
                }
                viewScale.bottomscale += 1
                
                if viewScale.bottomscale > 4 {
                    viewScale.bottomscale = 4
                }
            }
        }
    }
    func pageView(_ page: Int) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.yellow)
            VideoPlayer(player: AVPlayer(url:  URL(string:getURL(page) )!))
        }
        .cornerRadius(5)
        .shadow(radius: 5)
    }
}
struct topView : View {
    var body: some View{
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.white)
            .frame(height: 500.0)
    }
}

struct bottomView : View {
    var body: some View{
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.red)
            .frame(height: 500.0)
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewScale : ViewScaleObject())
    }
}
