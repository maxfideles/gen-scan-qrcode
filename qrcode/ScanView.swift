//
//  ScanView.swift
//  qrcode
//
//  Created by Max Victor on 22/02/2023.
//

import SwiftUI



struct ScanView: View {
   
    @EnvironmentObject var vm: ScanViewModel
    
    var body: some View {
     
        switch vm.dataScannerAccessStatus{
            case .scannerAvailable:
                    Text("The scanner is available")
            case .cameraNoatAvailable :
                    Text("The camera is not available")
            case .scannerNotAvailable:
                Text("Your device does not have support for scanning text and qrcode with this app")
            case .cameraAccessNotGranted:
                Text("please, provide acess to the camera in settings")
            case .notDetermined:
            Text("Requesting camera access")
            
                
        
            
        }
        
        
    }
}


struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
            .environmentObject(ScanViewModel())
    }
}
