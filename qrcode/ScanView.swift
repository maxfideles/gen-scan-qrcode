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
                   mainScannerView
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
    
    
    private var mainScannerView: some View{
        DataScannerView(recognizedItems: $vm.recognizedItems ,
                        recognizedDataType: vm.recognizedDataType,
                        reconizeMultipleItens: vm.recognizesMultiplesItems)
    }
    
}


struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
            .environmentObject(ScanViewModel())
    }
}
