//
//  LoginView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthManager  // ✅ conexión con el servicio
    @State private var email = ""
    @State private var password = ""
    @State private var mostrarError = false
    @State private var navegarMenu = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // 🖼️ Logo
                Image("LOGO")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()

                // 🧾 Títulos
                VStack(spacing: 2) {
                    Text("Bienvenido")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Ingeniero")
                        .font(.title2)
                        .fontWeight(.bold)
                }

                // 📧 Email
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                // 🔒 Contraseña
                SecureField("Contraseña", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                // 🚀 Botón de login
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
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }
                .scaleEffect(mostrarError ? 1.05 : 1.0)
                .animation(.easeInOut, value: mostrarError)

                // ❌ Mensaje de error
                if mostrarError {
                    Text("Usuario o contraseña incorrectos")
                        .foregroundColor(.red)
                        .font(.caption)
                        .transition(.opacity.combined(with: .slide))
                }

                // 🧭 Navegación al menú principal
                NavigationLink("", destination: PantallaMenu(), isActive: $navegarMenu)

                // 🔗 Enlaces extra
                Button("¿Olvidaste tu contraseña?") {}
                    .foregroundColor(.blue)

                NavigationLink("Registro", destination: RegisterView())
                    .underline()
                    .padding(.top)
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager()) // necesario para vista previa
}
