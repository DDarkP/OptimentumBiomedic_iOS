//
//  OptimentumBiomedicApp.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 1/11/25.
//

import SwiftUI

@main
struct TuApp: App {
    @StateObject var auth = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView()
            }
            .environmentObject(auth)
        }
    }
}

