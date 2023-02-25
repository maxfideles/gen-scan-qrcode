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

// creating a enum to representthe data scanner access status type in the app
//Based on state we going to present a specific UI

enum DataScannerAccessStatusType{
    case notDetermined //When Open the app
    case cameraAccessNotGranted //When user does not give acces to camera
    case cameraNoatAvailable //When camera is not present on the device
    case scannerAvailable  // When DataScanner is available to use
    case scannerNotAvailable //DataScanner is available for devices after bionic 12 onlny
    
}

@MainActor //It mens that this class will be executed inthe Main dispatch queue
final class ScanViewMode: ObservableObject{
    
    @Published var dataScannerAccessStatus: DataScannerAccessStatusType = .notDetermined
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
