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
    @State private var isPresentedMain : Bool = false
    @State private var showingImagePicker : Bool = false
    @State private var inputImage : UIImage?
    var body: some View {
        VStack{
            
            Button("로그인"){
                self.isPresentedLogin.toggle()
            }.fullScreenCover(isPresented: self.$isPresentedLogin, content:
                                LoginVCRepresentation.init)
            
            Button("메인화면"){
                self.isPresentedMain.toggle()
            }.fullScreenCover(isPresented: self.$isPresentedMain, content: MainView.init)
            Button("requestList"){
                APISearch.Request(uid: "22bbccdd").send { (respose) in
                    print(respose)
                }
            }
            Button("requestDetail"){
                APISearchDetail.Request(pid: "22bbccdd").send { (response) in
                    print(response)
                }
            }
            Button("upload"){
                self.showingImagePicker = true
            }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                ImagePicker(image: self.$inputImage)
            }
            Button("Crash test"){
                fatalError()
            }
            
        }
    }
    
    func loadImage(){
        guard let inputImage = inputImage else {
            return
        }
        Image(uiImage: inputImage)
        let meta = APISellUpload.Request.Meta(token: "abmnsda23349asdm1239c72", uid: "29df898eqr738sdf91g", title: "100년 묵은 홍삼", body: "여러분 안녕하세요~ \n오늘은 잇님들에게 100년 묵은 홍삼을 소개시켜드리려고 해요~~~\n(X같은 문 이모티콘)", category: ["건강기능 식품","건강식품"])
        APISellUpload.Request(meta: meta, media: inputImage.jpegData(compressionQuality: 0.2)!).send { (response) in
            print(response)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
