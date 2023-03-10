//
//  ScanViewModel.swift
//  qrcode
//
//  Created by Max Victor on 25/02/2023.
//

import Foundation
import SwiftUI
import VisionKit
import AVKit

// Creating an enum to define the Scan Types
enum ScanType{
    case barcode,text
}


// creating a enum to represent the data scanner access status type in the app
//Based on state we going to present a specific UI

enum DataScannerAccessStatusType{
    case notDetermined //When Open the app
    case cameraAccessNotGranted //When user does not give acces to camera
    case cameraNoatAvailable //When camera is not present on the device
    case scannerAvailable  // When DataScanner is available to use
    case scannerNotAvailable //DataScanner is available for devices after bionic 12 onlny
    
}

@MainActor //It means that this class will be executed in the Main dispatch queue
final class ScanViewModel: ObservableObject{
    
    @Published var dataScannerAccessStatus: DataScannerAccessStatusType = .notDetermined
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var scanType: ScanType = .barcode
    @Published var textContentType: DataScannerViewController.TextContentType?
    @Published var recognizesMultiplesItems = true
    
    
    //creating a variable that will generate the recognizeDataType based on Published variables
   
    var recognizedDataType: DataScannerViewController.RecognizedDataType {
            scanType == .barcode ? .barcode() : .text(textContentType: textContentType)
        }
    
    
    private var isScannerAvailable: Bool{
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
  //  DataScanner Status and defined inicialy as not determined
    func requestDataScannerStatus() async{
        //checking with the device has camera
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else{
            dataScannerAccessStatus = .cameraNoatAvailable
            return
        }
        
        //Asking for camera access
        switch AVCaptureDevice.authorizationStatus(for: .video){
        
            case .authorized:
            dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
        
            case .restricted, .denied:
            dataScannerAccessStatus = .cameraAccessNotGranted
            
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted{
                dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            } else{
                dataScannerAccessStatus = .cameraAccessNotGranted
            }
        default: break
            
        }
        
        
        
    }
    

    
}
