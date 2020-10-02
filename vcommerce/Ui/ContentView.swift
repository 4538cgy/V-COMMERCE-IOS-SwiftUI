//
//  ContentView.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/09/29.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresentedLogin : Bool = false
    @State private var isPresentedMain : Bool = false
    var body: some View {
        VStack{
            
            Button("로그인"){
                self.isPresentedLogin.toggle()
            }.fullScreenCover(isPresented: self.$isPresentedLogin, content: LoginView.init)
            
            Button("메인화면"){
                self.isPresentedMain.toggle()
            }.fullScreenCover(isPresented: self.$isPresentedMain, content: MainView.init)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
