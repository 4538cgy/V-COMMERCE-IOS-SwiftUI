//
//  ContentView.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/09/29.
//

import SwiftUI
import UIKit
import FirebaseCrashlytics


struct ContentView: View {
    @State private var isPresentedLogin : Bool = false
    var body: some View {
        VStack{
                
            Text("Splash").onAppear(perform: {
                delayText()
            }).fullScreenCover(isPresented: self.$isPresentedLogin, content: {
                LoginVCRepresentation.init()
            })
        
        }
    }
    private func delayText() {
        // Delay of 7.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("now")
            isPresentedLogin = true
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
