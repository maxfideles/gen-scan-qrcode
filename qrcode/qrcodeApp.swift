//
//  qrcodeApp.swift
//  qrcode
//
//  Created by Max Victor on 21/02/2023.
//

import SwiftUI

@main
struct qrcodeApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Image(systemName: "qrcode")
                        Text("criar")
                    }
                ScanView()
                    .tabItem {
                        Image(systemName: "camera")
                        Text("Scanear")}
            }
            .accentColor(.red)
            
        }
    }
}
