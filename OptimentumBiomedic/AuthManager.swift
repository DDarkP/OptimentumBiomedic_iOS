//
//  AuthManager.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//

import Foundation
import SwiftUI

class AuthManager: ObservableObject {
    @Published var usuarioActual: Usuario?
    @Published var usuarios: [Usuario] = []
    
    private let usuariosKey = "usuarios_registrados"
    
    init() {
        cargarUsuarios()
    }
    
    // MARK: - Registro
    func registrar(nombre: String, email: String, password: String) -> Bool {
        if usuarios.contains(where: { $0.email.lowercased() == email.lowercased() }) {
            return false // correo ya existe
        }
        
        let nuevoUsuario = Usuario(nombre: nombre, email: email, password: password)
        usuarios.append(nuevoUsuario)
        guardarUsuarios()
        usuarioActual = nuevoUsuario
        return true
    }
    
    // MARK: - Login
    func login(email: String, password: String) -> Bool {
        if let usuario = usuarios.first(where: {
            $0.email.lowercased() == email.lowercased() && $0.password == password
        }) {
            usuarioActual = usuario
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Cerrar sesión
    func logout() {
        usuarioActual = nil
    }
    
    // MARK: - Persistencia local
    private func guardarUsuarios() {
        if let encoded = try? JSONEncoder().encode(usuarios) {
            UserDefaults.standard.set(encoded, forKey: usuariosKey)
        }
    }
    
    private func cargarUsuarios() {
        if let data = UserDefaults.standard.data(forKey: usuariosKey),
           let decoded = try? JSONDecoder().decode([Usuario].self, from: data) {
            usuarios = decoded
        }
    }
}
