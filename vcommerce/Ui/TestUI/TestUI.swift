//
//  TestUI.swift
//  vcommerce
//
//  Created by JeongU Park on 2020/12/19.
//

import SwiftUI

struct TestUI: View {
    @State private var isPresentedLogin : Bool = false
    @State private var isPresentedMain : Bool = false
    @State private var showingImagePicker : Bool = false
    @State private var isPresentedCart : Bool = false
    @State private var isPresentedReview: Bool = false
    @State private var isPresentedSelectOption : Bool = false
    @State private var isPresentedLoginEamil : Bool = false
    @State private var isProduct : Bool = false
    @State private var inputImage : UIImage?
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            VStack{
                Button("로그인"){
                    self.isPresentedLogin.toggle()
                }.fullScreenCover(isPresented: self.$isPresentedLogin, content:
                                    LoginVCRepresentation.init)
                Button("Cart"){
                    self.isPresentedCart.toggle()
                }.fullScreenCover(isPresented: self.$isPresentedCart, content:
                                    CartVCRepresentation.init)
                Button("Review"){
                    self.isPresentedReview.toggle()
                }.fullScreenCover(isPresented: self.$isPresentedReview, content:
                                    ReviewVCRepresentation.init)
                Button("메인화면"){
                    self.isPresentedMain.toggle()
                }.fullScreenCover(isPresented: self.$isPresentedMain, content: MainView.init)
                Button("requestList"){
                    APISearch(uid : "22bbccdd").send { (items) in
                        print("\(items)")
                    } fail: { (errorMsg) in
                        print(errorMsg)
                    }
                    
                }
            }
            VStack{
                Button("requestDetail"){
                    APISearchDetail(pid:  "22bbccdd").send { (response) in
                        print("\(response)")
                    } fail: { (errorMsg) in
                        print("\(errorMsg)")
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
                Button("Login Email"){
                    self.isPresentedLoginEamil.toggle()
                }.fullScreenCover(isPresented: self.$isPresentedLoginEamil, content:
                                    LoginEmailVCRepresentation.init)
                Button("Selct Option"){
                    self.isPresentedSelectOption.toggle()
                }.fullScreenCover(isPresented: self.$isPresentedSelectOption, content:
                                    SelectOptionVCRepresentation.init)
                Button("Product"){
                    self.isProduct.toggle()
                }.fullScreenCover(isPresented: self.$isProduct, content:
                                    ProductVCRepresentation.init)
                Button("Back"){
                    self.presentationMode.wrappedValue.dismiss()
                }
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

struct TestUI_Previews: PreviewProvider {
    static var previews: some View {
        TestUI()
    }
}
