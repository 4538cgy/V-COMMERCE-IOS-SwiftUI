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
            VStack{
                PagesContainer(contentCount: 4,viewScale : viewScale) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.green.opacity(0.3))
                            .padding()
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                VStack{
                                    Image("btn-profile")
                                    Image("Like")
                                }.frame(height: 240, alignment: .center).offset(x: -8)
                            }
                        }
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.yellow.opacity(0.3))
                            .padding()
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                VStack{
                                    Image("btn-profile")
                                    Image("Like")
                                }.frame(height: 240, alignment: .center).offset(x: -8)
                            }
                        }
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.red.opacity(0.3))
                            .padding()
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                VStack{
                                    Image("btn-profile")
                                    Image("Like")
                                }.frame(height: 240, alignment: .center).offset(x: -8)
                            }
                        }
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.blue.opacity(0.3))
                            .padding()
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                VStack{
                                    Image("btn-profile")
                                    Image("Like")
                                }.frame(height: 240, alignment: .center).offset(x: -8)
                            }
                        }
                    }
                }.frame(height: UIScreen.main.bounds.height - 100 , alignment: .center).offset(x: 0, y: -10)
            }.frame(height : UIScreen.main.bounds.height, alignment: getAlignment(isState: viewScale.isMainViewStat))
            ZStack{
                topView()
                    .offset(x: 0, y: viewScale.getTopScale())
                    .gesture(DragGesture().onChanged({ (value) in
                        checkStart(height: value.translation.height)
                    }).onEnded({ (value) in
                        checkEndDrageGesture(height: value.translation.height)
                    })).animation(.spring())
                bottomView(viewScale: viewScale).offset(x: 0, y: viewScale.bottomscale * 160 ).gesture(DragGesture().onChanged({ (value) in
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
    func getAlignment(isState : Bool) -> Alignment {
        if isState {
            return .bottom
        }else{
            return .top
        }
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
            if (height - self.startYPoint) < -100 { // 하단에서 상단으로 슬라이드
                viewScale.setUpSwipe()
                
            }else if (height - self.startYPoint) > 100 { // 상단에서 하단으로 슬라이드  
                viewScale.setDownSwipe()
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
    
    @State private var isPresentedTest : Bool = false
    var body: some View{
        
        VStack{
            VStack{
                
                HStack(alignment: .center){
                    Button("Setting"){
                        
                    }
                    Button("TestUI"){
                        self.isPresentedTest.toggle()
                    }.fullScreenCover(isPresented: self.$isPresentedTest, content: TestUI.init)
                    Spacer()
                }.padding(.top, 270).padding([.leading, .bottom, .trailing], 10.0)
                
            }
        }.background(RoundedRectangle(cornerRadius: 8)
                        .fill(Color.yellow)
                        .frame(height: 300.0))
        
    }
}

struct bottomView : View {
    @ObservedObject var viewScale : ViewScaleObject
    var body: some View{
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.red)
            .frame(height: 500.0).onChange(of: self.viewScale.bottomscale, perform: { value in
                print("value : \(value)")
            })
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewScale : ViewScaleObject())
    }
}
