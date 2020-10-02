//
//  LoginView.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/10/01.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password : String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Back")
            }).position(x: 20.0, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .center){
                Text("Hello, LoginView")
                VStack{
                    TextField("Email", text: $email)
                    Divider()
                }.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                VStack{
                    SecureField("Password", text: $password)
                    Divider()
                }.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Button(action: {
                    print("Login ")
                }){
                    Spacer()
                    Text("로그인")
                        .foregroundColor(Color.black)
                    Spacer()
                }.frame(height: 40.0).border(Color.black).padding(.horizontal,10)
                Button(action: {
                    print("button pressed")
                }){
                    Image(uiImage: UIImage(named: "btn_signin_facebook.png")!).resizable().scaledToFit().overlay(ImageOverlay(title: "Facebook Login"))
                }.frame(height: 40.0).padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    print("button pressed")
                }){
                    Image(uiImage: UIImage(named: "btn_signin_google.png")!).resizable().scaledToFit().overlay(ImageOverlay(title: "Google Login"))
                }.frame(height: 40.0).padding(.horizontal,10)
            }
        }
    }
}

struct ImageOverlay: View {
    var title : String
    var body: some View {
        ZStack {
            Text(title)
                .font(.callout)
                .foregroundColor(.white)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
        }
        
    }
}
