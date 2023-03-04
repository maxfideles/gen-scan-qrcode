//
//  qrcodeApp.swift
//  qrcode
//
//  Created by Max Victor on 21/02/2023.
//

import SwiftUI

@main
struct qrcodeApp: App {
    @StateObject private var svm = ScanViewModel()
    @StateObject private var vm = qrCodeViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environmentObject(vm)
                    .tabItem {
                        Image(systemName: "qrcode")
                        Text("Create")
                    }
                ScanView()
                    .environmentObject(svm)
                    .task {
                        await svm.requestDataScannerStatus()
                    }
                    .tabItem {
                        Image(systemName: "camera")
                        Text("Scan")}
            }
            .accentColor(.red)
            
        }
    }
}
