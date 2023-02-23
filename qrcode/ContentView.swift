//
//  ContentView.swift
//  qrcode
//
//  Created by Max Victor on 21/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State var endereco:String = ""
    @State var userIn:String = ""
    @State var shadqrcode:Bool = false
    
    var body: some View {
        
        VStack{
            
            VStack {
                
                Text("Gerador QRCode")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .offset(y:-50)
                
                QrCodeView(url: endereco)
                    .padding()
                    .border(.white)
                    .cornerRadius(40)
                    .shadow(color: shadqrcode ? .white : .black, radius: 20)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 111/255, green: 18/255, blue: 37/255 ))
            
            VStack{
                ZStack(alignment: .trailing){
                    TextField("  Digite endereço...", text: $userIn)
                        .frame(width: 350, height: 50)
                        .font(.headline.bold())
                        .foregroundColor(Color(.white))
                        .background(Color(red: 111/255, green: 18/255, blue: 37/255).cornerRadius(30))
                        .colorScheme(.dark)
                    Button {
                        withAnimation {
                            userIn.removeAll()
                            endereco.removeAll()
                            shadqrcode = false
                        }
                    } label: {
                        Image(systemName: "trash")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                }
                
                Button {
                    saveGenerate()
                    shadqrcode.toggle()
                } label: {
                    Text("Gerar")
                        
                        .frame(width: 150, height: 50)
                        .font(.headline.bold())
                        .foregroundColor(Color(.white))
                        .background(Color(red: 111/255, green: 18/255, blue: 37/255).cornerRadius(30))
                        .colorScheme(.dark)
                        .shadow(color: Color.black.opacity(0.8),radius:5, x: 5, y:5)
                }
                .padding(.top,20)

            }
            .frame(maxWidth: .infinity , maxHeight: 300)
            .background(.white)
            
            
            
        }
        
    }
    func saveGenerate(){
        endereco.append(userIn.lowercased())
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
