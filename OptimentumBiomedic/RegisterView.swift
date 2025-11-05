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
        VStack(spacing: 20) {
            // Título
            Text("Registro de Usuario")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Campos
            Group {
                TextField("Nombres", text: $nombres)
                    .textInputAutocapitalization(.words)
                TextField("Apellidos", text: $apellidos)
                    .textInputAutocapitalization(.words)
                TextField("Correo electrónico", text: $correo)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Contraseña", text: $password)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)

            // Botón Registrar
            Button(action: registrarUsuario) {
                Text("Registrar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(radius: 3)
            }
            .scaleEffect(mostrarError ? 1.05 : 1.0)
            .animation(.easeInOut, value: mostrarError)

            // Navegación al menú
            NavigationLink("", destination: PantallaMenu(), isActive: $navegarAMenu)
        }
        .padding()
        .alert(isPresented: $mostrarAlerta) {
            Alert(title: Text(mensaje))
        }
    }

    private func registrarUsuario() {
        guard !nombres.isEmpty, !apellidos.isEmpty, !correo.isEmpty, !password.isEmpty else {
            mensaje = "Por favor completa todos los campos ❌"
            mostrarError = true
            mostrarAlerta = true
            return
        }

        if auth.registrar(nombre: nombres, email: correo, password: password) {
            mensaje = "Registro exitoso ✅"
            mostrarError = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                navegarAMenu = true
            }
        } else {
            mensaje = "El correo ya está registrado ❌"
            mostrarError = true
        }

        mostrarAlerta = true
    }
}

#Preview {
    RegisterView().environmentObject(AuthManager())
}
