//
//  DataScannerView.swift
//  qrcode
//
//  Created by Max Victor on 02/03/2023.
//

import Foundation
import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable{
    
    @Binding var recognizedItems: [RecognizedItem]
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    let reconizeMultipleItens: Bool
    
    
    func makeUIViewController(context: Context) -> DataScannerViewController{
        let vc = DataScannerViewController(
            recognizedDataTypes: [recognizedDataType],
            qualityLevel: .balanced,
            recognizesMultipleItems: reconizeMultipleItens,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
            )
        return vc
        
    }
    

    
    func updateUIViewController (_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems)
    }
    
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        uiViewController.stopScanning()
    }
    
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate{
        
        @Binding var recognizedItems: [RecognizedItem]
        
        init(recognizedItems: Binding<[RecognizedItem]>) {
            self._recognizedItems = recognizedItems
        }
        
        //What going to be in focus when the user tap in one of the recognized itens
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            print("didTapOn \(item)")
        }
        
        //What going to be in focus when new items will be recognized
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            //When recognized new items, it will provide a vibrater to the user
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            
            recognizedItems.append(contentsOf: addedItems)
            
            print("DidAddItems \(addedItems)")
        }
        
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            
            self .recognizedItems = recognizedItems.filter{ item in
                !removedItems.contains(where: {$0.id == item.id})
                
            }
            
            print("didRemovedItems \(removedItems)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("Become unavailable with erro \(error.localizedDescription)")
        }
        
    }
    
    
}
