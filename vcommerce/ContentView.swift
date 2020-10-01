//
//  ContentView.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/09/29.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented : Bool = false
    var body: some View {
        VStack{
            
            Button("로그인"){
                self.isPresented.toggle()
            }.fullScreenCover(isPresented: self.$isPresented, content: LoginView.init)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
