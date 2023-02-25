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
    @StateObject private var imageSaver = ImageSaver()
    @EnvironmentObject var tes : qrCodeViewModel
    @State var imglabel:String = "Scaneie com a câmera"
    
    var body: some View {
        
        VStack{
            
            VStack {
                Spacer()
                Text("Gerador QRCode")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .offset(y:-40)
                
                if shadqrcode == false{
                    Image(systemName: "qrcode")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 200)
                        .padding()
                        .border(.white)
                        .cornerRadius(40)
                        .shadow(color: shadqrcode ? .white : .black, radius: 20)
                }
                else{
                    Image(uiImage: tes.GerQrCodeImage(endereco))
                        .resizable()
                        .interpolation(.none)
                        .frame(width: 200, height: 200)
                        .padding()
                        .border(.white)
                        .cornerRadius(40)
                        .shadow(color: shadqrcode ? .white : .black, radius: 20)
                }
                Spacer()
                
                Button {
                    
                    if shadqrcode {
                        imageSaver.saveImage((tes.GerQrCodeImage(endereco)),imglabel)
                    }
                    
                    
                } label: {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title3.bold())
                        .disabled(true)
                       .foregroundColor(shadqrcode ? .white : .gray)
                }
                .disabled(shadqrcode == false)
                .alert(item: $imageSaver.saveResult){ saveResult in
                    return alert(forSaveStatus: saveResult.saveStatus)
                    
                }
                Spacer()
                
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
                    if userIn.isEmpty{
                        shadqrcode = false
                    }else{
                        
                        shadqrcode = true
                    }
                    
                    
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
    private func alert(forSaveStatus saveStatus: ImageStatus) -> Alert{
        switch saveStatus {
        case .Sucess:
            return Alert(
                title: Text( "Salvo!"),
                message: Text("QrCode foi salvo em sua galeria de fotos")
            )
        case .error:
            return Alert(
                title: Text( "Ooops!"),
                message: Text("Um erro ocorreu ao salvar seu QrCode")
            )
        case .libraryPermitionDenied:
            return Alert(
                    title: Text("Oops!"),
                    message: Text("Este app precisa de permissão para salvar fotos em sua galeriaThis."),
                    primaryButton: .cancel(Text("Ok")),
                    secondaryButton: .default(Text("Abrir Configurações")) {
                      guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                      UIApplication.shared.open(settingsUrl)
                    }
                  )
        }
        
        
    }
    
    func saveGenerate(){
    
        
        endereco.append(userIn.lowercased())
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(qrCodeViewModel())
        
        
    }
}
