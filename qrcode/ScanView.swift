//
//  ScanView.swift
//  qrcode
//
//  Created by Max Victor on 22/02/2023.
//

import SwiftUI



struct ScanView: View {
    @State var array:String = ""
    @State var url:String = ""
    
    var body: some View {
        
        VStack{
            
            VStack {
                Text("Gerador QRCode")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .offset(y:-50)
                
                Image(systemName: "qrcode")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 111/255, green: 18/255, blue: 37/255 ))
            
            VStack{
                ZStack(alignment: .trailing){
                    TextField("", text: $url)
                        .frame(width: 350, height: 50)
                        .font(.headline.bold())
                        .foregroundColor(Color(.white))
                        .background(Color(red: 111/255, green: 18/255, blue: 37/255).cornerRadius(30))
                        .colorScheme(.dark)
                    Button {
                        //
                    } label: {
                        Image(systemName: "trash")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                }
                
                Button {
                    //
                } label: {
                    Text("Acessar")
                        
                        .frame(width: 150, height: 50)
                        .font(.headline.bold())
                        .foregroundColor(Color(.white))
                        .background(Color(red: 111/255, green: 18/255, blue: 37/255).cornerRadius(30))
                        .colorScheme(.dark)
                }
                .padding()

            }
            .frame(maxWidth: .infinity , maxHeight: 300)
            .background(.white)
            
            
        }
        
    }
}


struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
