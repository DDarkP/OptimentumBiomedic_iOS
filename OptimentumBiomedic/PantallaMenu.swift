//
//  PantallaMenu.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//
import SwiftUI

struct PantallaMenu: View {
    @EnvironmentObject var auth: AuthManager
    @Environment(\.dismiss) var dismiss
    @State private var mostrarConfirmacion = false

    var body: some View {
        VStack(spacing: 20) {
            Image("LOGO")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()

            // 🧍‍♂️ Bienvenida dinámica
            if let usuario = auth.usuarioActual {
                Text("Bienvenido, \(usuario.nombre)")
                    .font(.title2)
                    .fontWeight(.bold)
            } else {
                Text("Bienvenido")
                    .font(.title2)
                    .fontWeight(.bold)
            }

            Text("¿Qué deseas hacer hoy?")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer().frame(height: 25)

            // 📋 Opciones del menú
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

            // 🚪 Botón de cerrar sesión
            Button(action: {
                mostrarConfirmacion = true
            }) {
                Text("Cerrar sesión")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .shadow(radius: 3)
            }
            .padding(.horizontal)
            .confirmationDialog(
                "¿Seguro que deseas cerrar sesión?",
                isPresented: $mostrarConfirmacion,
                titleVisibility: .visible
            ) {
                Button("Cerrar sesión", role: .destructive) {
                    withAnimation(.easeInOut) {
                        auth.logout()
                        dismiss()
                    }
                }
                Button("Cancelar", role: .cancel) { }
            }
        }
        .padding()
        .background(Color(red: 245/255, green: 240/255, blue: 238/255))
    }
}

// 🎨 Estilo de botones del menú
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
    NavigationView {
        PantallaMenu()
            .environmentObject(AuthManager())
    }
}
