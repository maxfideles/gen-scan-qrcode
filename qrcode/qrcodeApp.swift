//
//  qrcodeApp.swift
//  qrcode
//
//  Created by Max Victor on 21/02/2023.
//

import SwiftUI

@main
struct qrcodeApp: App {
    @StateObject private var vm = qrCodeViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environmentObject(vm)
                    .tabItem {
                        Image(systemName: "qrcode")
                        Text("criar")
                    }
                ScanView()
                    .environmentObject(vm)
                    .tabItem {
                        Image(systemName: "camera")
                        Text("Scanear")}
            }
            .accentColor(.red)
            
        }
    }
}
