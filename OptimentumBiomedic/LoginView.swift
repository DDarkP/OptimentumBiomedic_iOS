//
//  LoginView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//

import SwiftUI
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthManager
    @State private var email = ""
    @State private var password = ""
    @State private var mostrarError = false
    @State private var navegarMenu = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo principal con gradiente biomédico
                AppTheme.gradientePrincipal
                    .ignoresSafeArea()

                VStack(spacing: 25) {
                    // Logo
                    Image("LOGO")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .padding(.bottom, 10)

                    // Campos de texto personalizados
                    CampoTexto(placeholder: "Correo electrónico", texto: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    CampoTexto(placeholder: "Contraseña", texto: $password, esSeguro: true)

                    // Botón de login
                    Button(action: {
                        if auth.login(email: email.lowercased(), password: password) {
                            withAnimation(.easeInOut) {
                                navegarMenu = true
                                mostrarError = false
                            }
                        } else {
                            withAnimation(.spring()) {
                                mostrarError = true
                            }
                        }
                    }) {
                        Text("Iniciar sesión")
                            .font(AppTheme.fuenteSubtitulo)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(AppTheme.colorResaltado.opacity(0.9))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                    }
                    .scaleEffect(mostrarError ? 1.05 : 1.0)
                    .animation(.easeInOut, value: mostrarError)

                    //  Error
                    if mostrarError {
                        Text("Usuario o contraseña incorrectos")
                            .foregroundColor(.red)
                            .font(AppTheme.fuentePequena)
                            .transition(.opacity.combined(with: .slide))
                    }

                    // Navegación
                    NavigationLink("", destination: PantallaMenu(), isActive: $navegarMenu)

                    // Extras
                    VStack(spacing: 8) {
                        Button("¿Olvidaste tu contraseña?") {}
                            .foregroundColor(.white)
                            .font(AppTheme.fuentePequena)

                        NavigationLink("Registrarse", destination: RegisterView())
                            .foregroundColor(AppTheme.colorPrimario)
                            .underline()
                            .font(AppTheme.fuenteNormal)
                    }
                    .padding(.top, 10)
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager())
}

#Preview {
    LoginView()
        .environmentObject(AuthManager()) // necesario para vista previa
}
