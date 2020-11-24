//
//  MainView.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/02.
//

import SwiftUI
import SwiftUIPager
import AVKit

struct MainView: View {
    @State var page: Int = 0
    @State private var bottomscale: CGFloat = 3
    @State private var topToggle: Bool = false
    

    var items = Array(0..<10)
    var body: some View {
        ZStack{
            Pager(page: $page,
                  data: items,
                  id: \.self,
                  content: { page in
                    self.pageView(page)
                  }).rotation3D()
           ZStack{
                topView()
                    .offset(x: 0, y: topToggle ? -450 : -550)
                    .onTapGesture(perform: {
                        self.topToggle.toggle()
                    }).animation(.spring())
                bottomView().offset(x: 0, y: bottomscale * 160 ).onTapGesture(perform: {
                    bottomscale -= 1
                    if bottomscale == 0 {
                        bottomscale = 3
                    }
                }).animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
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
        MainView()
    }
}
