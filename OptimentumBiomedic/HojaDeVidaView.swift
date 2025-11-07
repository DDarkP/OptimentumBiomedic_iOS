//
//  HojaDeVidaView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//
//
//  HojaDeVidaView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//
import SwiftUI

struct HojaDeVidaView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var pagina = 1
    
    // Primera vista
    @State private var nombredelequipo = ""
    @State private var descripcion = ""
    @State private var marca = ""
    @State private var modelo = ""
    @State private var serie = ""
    
    // Segunda vista
    @State private var claseRiesgo1 = ""
    @State private var claseTipos = ""
    @State private var voltajeMax = ""
    @State private var voltajeMin = ""
    @State private var corrienteMax = ""
    @State private var corrienteMin = ""
    
    let clases = ["Clase I", "Clase II", "Clase III"]
    let tipos = ["TIPO B", "TIPO BF", "TIPO CF", "TIPO H"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.gradientePrincipal
                    .ignoresSafeArea()
                
                VStack {
                    if pagina == 1 {
                        primeraPagina
                    } else {
                        segundaPagina
                    }
                }
            }
            .navigationBarBackButtonHidden(false)
            .onDisappear {
                // Limpia el estado si es necesario al salir
                pagina = 1
            }
        }
    }
    
    // MARK: - PRIMERA PÁGINA
    private var primeraPagina: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("HOJA DE VIDA")
                .font(AppTheme.fuenteTitulo)
                .foregroundColor(AppTheme.colorTexto)
                .padding(.top, 8)
            
            CampoTexto(placeholder: "Nombre del equipo", texto: $nombredelequipo)
            
            Text("INFORMACIÓN GENERAL")
                .font(AppTheme.fuenteSubtitulo)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(AppTheme.colorPrimario.opacity(0.9))
                .cornerRadius(12)
            
            CampoTexto(placeholder: "Descripción del equipo", texto: $descripcion)
            CampoTexto(placeholder: "Marca del equipo", texto: $marca)
            CampoTexto(placeholder: "Modelo del equipo", texto: $modelo)
            CampoTexto(placeholder: "Serie del equipo", texto: $serie)
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: { pagina = 2 }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title)
                        .foregroundColor(AppTheme.colorSecundario)
                }
                .padding([.bottom, .trailing], 12)
            }
        }
        .padding()
    }
    
    // MARK: - SEGUNDA PÁGINA
    private var segundaPagina: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("HOJA DE VIDA")
                .font(AppTheme.fuenteTitulo)
                .foregroundColor(AppTheme.colorTexto)
                .padding(.top, 8)
            
            Text("REGISTRO TÉCNICO")
                .font(AppTheme.fuenteSubtitulo)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(AppTheme.colorPrimario.opacity(0.9))
                .cornerRadius(12)
            
            Text("CLASIFICACIÓN DE RIESGO ELÉCTRICO")
                .foregroundColor(AppTheme.colorTexto)
                .font(AppTheme.fuenteNormal)
            
            HStack {
                Picker("Clase...", selection: $claseRiesgo1) {
                    ForEach(clases, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
                .padding()
                .background(AppTheme.colorFondo.opacity(0.3))
                .cornerRadius(12)
                
                Picker("Tipo...", selection: $claseTipos) {
                    ForEach(tipos, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
                .padding()
                .background(AppTheme.colorFondo.opacity(0.3))
                .cornerRadius(12)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("VOLTAJES DE OPERACIÓN")
                    .foregroundColor(AppTheme.colorTexto)
                HStack {
                    CampoTexto(placeholder: "MAX", texto: $voltajeMax)
                    CampoTexto(placeholder: "MIN", texto: $voltajeMin)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("CORRIENTES DE OPERACIÓN")
                    .foregroundColor(AppTheme.colorTexto)
                HStack {
                    CampoTexto(placeholder: "MAX", texto: $corrienteMax)
                    CampoTexto(placeholder: "MIN", texto: $corrienteMin)
                }
            }
            
            Spacer()
            
            HStack {
                Button(action: { pagina = 1 }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title)
                        .foregroundColor(AppTheme.colorSecundario)
                }
                Spacer()
                Button(action: {
                    // Acción guardar
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.title)
                        .foregroundColor(AppTheme.colorSecundario)
                }
            }
            .padding([.bottom, .horizontal], 12)
        }
        .padding()
    }
}

#Preview {
    HojaDeVidaView()
}
