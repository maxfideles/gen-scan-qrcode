//
//  qrCodeViewModel.swift
//  qrcode
//
//  Created by Max Victor on 24/02/2023.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

final class qrCodeViewModel: ObservableObject{
    
    @Published var url: String? = nil
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    let transform = CGAffineTransform(scaleX: 10, y: 10)
    
    func GerQrCodeImage(_ url: String) -> UIImage{
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let qrcode = filter.outputImage?.transformed(by: transform){
            if let qrcodeImage = context.createCGImage(qrcode, from: qrcode.extent){
                
                let qrcodeFinal = UIImage(cgImage: qrcodeImage)
                return qrcodeFinal
                
            }
        }
        return  UIImage(systemName: "xmark") ?? UIImage()
    }
    
    
    
}
