//
//  LoginView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var navegarADetalles = false
    @State private var mostrarError = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image("LOGO") // Logo en tus Assets
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack(spacing: 2) {
                Text("Bienvenido")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Ingeniero")
                    .font(.title2)
                    .fontWeight(.bold)
            }

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            SecureField("Contraseña", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            Button(action: {
                if email.lowercased() == "admin@correo.com" && password == "12345" {
                    navegarADetalles = true
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

            if mostrarError {
                Text("Usuario o contraseña incorrectos")
                    .foregroundColor(.red)
                    .font(.caption)
                    .transition(.opacity.combined(with: .slide))
            }

            NavigationLink("", destination: PantallaMenu(), isActive: $navegarADetalles)

            Button("¿Olvidaste tu contraseña?") {}
                .foregroundColor(.blue)

            NavigationLink("Registro", destination: RegisterView())
                .underline()
                .padding(.top)
        }
        .padding()
    }
}


#Preview {
    LoginView()
}
