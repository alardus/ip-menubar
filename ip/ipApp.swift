//
//  ipApp.swift
//  ip
//
//  Created by Alexander Bykov on 29.01.25.
//

import SwiftUI

@main
struct ipApp: App {
    @StateObject private var viewModel = IPViewModel()
    
    init() {
        // Скрываем иконку из Dock
        NSApplication.shared.setActivationPolicy(.accessory)
    }
    
    var body: some Scene {
        MenuBarExtra {
            VStack {
                Text(viewModel.displayText)
                    .padding()
                
                Divider()

                Text("Версия: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Неизвестно")")
                    .padding(.vertical, 5)

                Divider()                
                
                Button("Exit") {
                    NSApplication.shared.terminate(nil)
                }
                .padding(.vertical, 5)
            }
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "network")
                Text(viewModel.countryCode)
            }
        }
    }
}
