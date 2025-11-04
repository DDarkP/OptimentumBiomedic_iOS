//
//  PantallaMenu.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//

import SwiftUI

struct PantallaMenu: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("LOGO")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()

            Text("Bienvenido, Inge")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("¿Qué deseas hacer hoy?")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer().frame(height: 25)

            VStack(spacing: 10) {
                NavigationLink("REALIZAR HOJAS DE VIDA", destination: HojaDeVidaView())
                    .buttonStyle(MenuButtonStyle(color: .green.opacity(0.4)))

                NavigationLink("COTIZACIONES", destination: CotizacionView())
                    .buttonStyle(MenuButtonStyle(color: .blue.opacity(0.3)))

                NavigationLink("INVENTARIO DE EQUIPOS", destination: InventarioView())
                    .buttonStyle(MenuButtonStyle(color: .green.opacity(0.4)))

                NavigationLink("CONTRATO", destination: ContratoView())
                    .buttonStyle(MenuButtonStyle(color: .blue.opacity(0.3)))
            }
            .padding()

            Spacer()
        }
        .padding()
        .background(Color(red: 245/255, green: 240/255, blue: 238/255))
    }
}

struct MenuButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundColor(.black)
            .cornerRadius(10)
            .font(.headline)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}


#Preview {
    PantallaMenu()
}
