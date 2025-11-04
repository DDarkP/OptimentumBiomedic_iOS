//
//  RegisterView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var nombres = ""
    @State private var apellidos = ""
    @State private var correo = ""
    @State private var password = ""
    @State private var navegarAMenu = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Registro")
                .font(.largeTitle)
                .fontWeight(.bold)

            Group {
                TextField("Nombres", text: $nombres)
                TextField("Apellidos", text: $apellidos)
                TextField("Correo", text: $correo)
                SecureField("Contraseña", text: $password)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)

            NavigationLink("", destination: PantallaMenu(), isActive: $navegarAMenu)
            
            Button("Registrar") {
                navegarAMenu = true
            }
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray)
            .cornerRadius(12)
            .underline()
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
