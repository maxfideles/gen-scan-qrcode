//
//  CodeImageSaver.swift
//  qrcode
//
//  Created by Max Victor on 22/02/2023.
//

import Photos
import UIKit

class ImageSaver: NSObject, ObservableObject{
    
    @Published public var saveResult: CodeImageSaver?
    
    
    public func saveImage(_ image: UIImage,_ Label: String){
        let imageLabel = Label
        let photoLibraryAuthStatus = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        if photoLibraryAuthStatus == .authorized {
            saveImage(image, withlabel: imageLabel)
            return
        }
        
        PHPhotoLibrary.requestAuthorization(for: .addOnly){status in
            DispatchQueue.main.async {
                if status == .authorized{
                    self.saveImage(image, withlabel: imageLabel)
                    return
                }
                self.saveResult = CodeImageSaver(saveStatus: .libraryPermitionDenied)
            }
        }
        
    }
    
    private func saveImage(_  image: UIImage, withlabel label: String){
        
        if let imageWithLabel = addLabel(label, toImage: image){
            UIImageWriteToSavedPhotosAlbum(imageWithLabel, self, #selector(saveFinished), nil)
            return
            
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveFinished), nil)
        
    }
    
    private func addLabel(_ label: String, toImage image: UIImage)-> UIImage? {
        let font = UIFont.boldSystemFont(ofSize: 20)
        let text: NSString = NSString(string: label)
        
        let attributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue
        ]
        
        let textPadding: CGFloat = 8
        
        let textSize = text.size(withAttributes: attributes)
        let heightOffset = textSize.height + textPadding*2
        let width = image.size.width
        let height = image.size.height + heightOffset
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        
        if let context = UIGraphicsGetCurrentContext(){
            UIColor.white.setFill()
            let rect = CGRect(x: 0, y: 0, width: width, height: height)
            context.fill(rect)
        }
        image.draw(in: CGRect(x: 0, y: heightOffset, width: width, height: image.size.height))
        text.draw(
            in: CGRect(
                x: CGFloat(Int((width / 2) - (textSize.width / 2))),
                y: textPadding,
                width: width, height: height),
            withAttributes: attributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
        
        
    }
    @objc private func saveFinished(
        _ Image: UIImage,
        didFinishSavingWithError error: Error?,
        conextInfor: UnsafeRawPointer
    ){
        if error != nil{
            saveResult = CodeImageSaver(saveStatus: .error)
        }else{
            saveResult = CodeImageSaver(saveStatus: .Sucess)
        }
    }
}



struct CodeImageSaver: Identifiable{
    let id = UUID()
    let saveStatus: ImageStatus
    
    
}

enum ImageStatus{
    case Sucess
    case error
    case libraryPermitionDenied
}
