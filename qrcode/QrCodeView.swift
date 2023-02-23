//
//  QrCodeView.swift
//  qrcode
//
//  Created by Max Victor on 21/02/2023.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QrCodeView: View{
    
    var url: String
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        Image(uiImage: GenerateQrCodeImage(url))
            .resizable()
            .interpolation(.none)
            .frame(width: 200, height: 200)
        
    }
    
    func GenerateQrCodeImage(_ url: String) -> UIImage{
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let qrcode = filter.outputImage{
            if let qrcodeImage = context.createCGImage(qrcode, from: qrcode.extent){
                
                return UIImage(cgImage: qrcodeImage)
                
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
    
    
}
