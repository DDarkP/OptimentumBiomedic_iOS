//
//  AppTheme.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 6/11/25.
//
import SwiftUI

struct AppTheme {
    // Colores
    static let colorPrimario = Color("ColorPrimario")
    static let colorSecundario = Color("ColorSecundario")
    static let colorFondo = Color("ColorFondo")
    static let colorTexto = Color("ColorTexto")
    static let colorResaltado = Color("ColorResaltado")

    // Tipografía
    static let fuenteTitulo = Font.system(size: 28, weight: .bold, design: .rounded)
    static let fuenteSubtitulo = Font.system(size: 20, weight: .semibold, design: .rounded)
    static let fuenteNormal = Font.system(size: 16, design: .rounded)
    static let fuentePequena = Font.system(size: 13, design: .rounded)

    // Gradientes y fondos
    static let gradientePrincipal = LinearGradient(
        colors: [ colorPrimario, colorPrimario.opacity(0.2)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
