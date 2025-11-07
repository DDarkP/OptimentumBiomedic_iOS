//
//  RegisterView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//
import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var auth: AuthManager
    @State private var nombres = ""
    @State private var apellidos = ""
    @State private var correo = ""
    @State private var password = ""
    @State private var mostrarAlerta = false
    @State private var navegarAMenu = false
    @State private var mensaje = ""
    @State private var mostrarError = false

    var body: some View {
        ZStack {
            // Fondo con gradiente
            AppTheme.gradientePrincipal
                .ignoresSafeArea()

            VStack(spacing: 25) {
                // Título principal
                Text("Registro de Usuario")
                    .font(AppTheme.fuenteTitulo)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.colorPrimario)
                    .padding(.top, 40)

                // Campos de entrada usando el componente reutilizable
                VStack(spacing: 15) {
                    CampoTexto(placeholder: "Nombres", texto: $nombres)
                    CampoTexto(placeholder: "Apellidos", texto: $apellidos)
                    CampoTexto(placeholder: "Correo electrónico", texto: $correo)
                    CampoTexto(placeholder: "Contraseña", texto: $password, esSeguro: true)
                }

                // Botón de registro
                Button(action: registrarUsuario) {
                    Text("Registrar")
                        .font(AppTheme.fuenteNormal)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(AppTheme.colorResaltado)
                        .cornerRadius(12)
                        .shadow(color: AppTheme.colorPrimario.opacity(0.4), radius: 5, x: 0, y: 3)
                }
                .scaleEffect(mostrarError ? 1.05 : 1.0)
                .animation(.easeInOut, value: mostrarError)

                // Navegación al menú principal
                NavigationLink("", destination: PantallaMenu(), isActive: $navegarAMenu)
            }
            .padding()
        }
        .alert(isPresented: $mostrarAlerta) {
            Alert(title: Text(mensaje))
        }
    }

    // MARK: - Lógica de registro
    private func registrarUsuario() {
        guard !nombres.isEmpty, !apellidos.isEmpty, !correo.isEmpty, !password.isEmpty else {
            mensaje = "Por favor completa todos los campos"
            mostrarError = true
            mostrarAlerta = true
            return
        }

        if auth.registrar(nombre: nombres, email: correo, password: password) {
            mensaje = "Registro exitoso"
            mostrarError = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                navegarAMenu = true
            }
        } else {
            mensaje = "El correo ya está registrado"
            mostrarError = true
        }

        mostrarAlerta = true
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthManager())
}
