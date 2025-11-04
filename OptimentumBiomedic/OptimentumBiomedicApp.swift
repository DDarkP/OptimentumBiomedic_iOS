//
//  OptimentumBiomedicApp.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 1/11/25.
//

import SwiftUI

@main
struct OptimentumBiomedicApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {   // Habilita navegación en la raíz
                LoginView()   // Vista inicial, puede navegar a otras vistas
            }
        }
    }
}
