//
//  CreditosView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 6/11/25.
//
import SwiftUI

struct CreditosView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Logo
                Image("LOGO")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .shadow(radius: 5)
                    .padding(.top, 30)
                
                // Nombre de la app
                Text("OPTIMENTUM BIOMEDIC")
                    .font(AppTheme.fuenteTitulo)
                    .foregroundColor(AppTheme.colorTexto)
                    .multilineTextAlignment(.center)
                
                // Descripción
                Text("""
                Optimentum Biomedic es una aplicación diseñada para optimizar la gestión de procesos biomédicos en instituciones y empresas del sector salud. Permite administrar hojas de vida de equipos, realizar cotizaciones, controlar inventarios y gestionar contratos de manera eficiente y centralizada.
                """)
                .font(AppTheme.fuenteNormal)
                .foregroundColor(AppTheme.colorTexto.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                
                Divider().background(AppTheme.colorSecundario)
                
                // Desarrolladores
                VStack(spacing: 10) {
                    Text("Desarrolladores")
                        .font(AppTheme.fuenteSubtitulo)
                        .foregroundColor(AppTheme.colorTexto)
                        .padding(.bottom, 5)
                    
                    Group {
                        Text("Daniel Muñoz Piedrahita")
                        Text("Maria Isabel Orozco Vejarano")
                    }
                    .font(AppTheme.fuenteNormal)
                    .foregroundColor(AppTheme.colorTexto)
                }

                Divider().background(AppTheme.colorSecundario)
                
                // Tecnología usada
                VStack(spacing: 8) {
                    Text("Tecnología usada")
                        .font(AppTheme.fuenteSubtitulo)
                        .foregroundColor(AppTheme.colorTexto)
                    
                    Text("Aplicación desarrollada en SwiftUI para iOS.")
                        .font(AppTheme.fuenteNormal)
                        .foregroundColor(AppTheme.colorTexto.opacity(0.8))
                }
                
                Divider().background(AppTheme.colorSecundario)
                
                // Agradecimientos
                VStack(spacing: 8) {
                    Text("Agradecimientos")
                        .font(AppTheme.fuenteSubtitulo)
                        .foregroundColor(AppTheme.colorTexto)
                    
                    Text("Agradecemos a la Universidad del Cauca y al docente guía por su apoyo durante el desarrollo del proyecto.")
                        .multilineTextAlignment(.center)
                        .font(AppTheme.fuenteNormal)
                        .foregroundColor(AppTheme.colorTexto.opacity(0.8))
                        .padding(.horizontal)
                }

                Divider().background(AppTheme.colorSecundario)

                // Versión
                VStack(spacing: 5) {
                    Text("Versión 1.0.0")
                        .font(AppTheme.fuentePequena)
                        .foregroundColor(AppTheme.colorTexto.opacity(0.7))
                    Text("© 2025 OPTIMENTUM BIOMEDIC. Todos los derechos reservados.")
                        .font(AppTheme.fuentePequena)
                        .foregroundColor(AppTheme.colorTexto.opacity(0.7))
                        .multilineTextAlignment(.center)
                }

                Spacer(minLength: 40)
            }
            .padding()
        }
        .background(AppTheme.gradientePrincipal.ignoresSafeArea()) // gradiente aplicado
        .navigationTitle("Créditos")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        CreditosView()
    }
}
