//
//  LockScreen_DockApp.swift
//  LockScreen Dock
//
//  Created by Andrei Bezlepkin on 12.12.22.
//

import SwiftUI

@main
struct LockScreen_DockApp: App {
    @Environment(\.openURL) var openURL
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    openURL(url)
                }
        }
    }
}
