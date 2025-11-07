//
//  ContratoView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//

import SwiftUI

struct Contrato: Identifiable, Codable {
    let id = UUID()
    var cliente: String
    var servicio: String
    var duracion: String
    var condiciones: String
}

struct ContratoView: View {
    @AppStorage("contratos") private var contratosData: Data = Data()
    @State private var contratos: [Contrato] = []

    @State private var cliente = ""
    @State private var servicio = ""
    @State private var duracion = ""
    @State private var condiciones = ""
    @State private var animar = false

    var body: some View {
        ZStack {
            AppTheme.gradientePrincipal
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 22) {
                    // Título principal
                    Text("Generar Contrato")
                        .font(AppTheme.fuenteTitulo)
                        .foregroundColor(AppTheme.colorTexto)
                        .padding(.top, 10)

                    // Campos de entrada
                    Group {
                        CampoTexto(placeholder: "Cliente", texto: $cliente)
                        CampoTexto(placeholder: "Servicio", texto: $servicio)
                        CampoTexto(placeholder: "Duración (meses)", texto: $duracion)
                            .keyboardType(.numberPad)

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Condiciones")
                                .font(AppTheme.fuenteSubtitulo)
                                .foregroundColor(AppTheme.colorTexto)

                            ZStack(alignment: .topLeading) {
                                // Fondo igual al de tus campos normales
                                AppTheme.colorFondo
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(AppTheme.colorSecundario.opacity(0.3), lineWidth: 1)
                                    )

                                // TextEditor sin fondo blanco
                                TextEditor(text: $condiciones)
                                    .scrollContentBackground(.hidden) // 👈 esto elimina el fondo blanco por defecto
                                    .frame(height: 120)
                                    .padding(8)
                                    .font(AppTheme.fuenteNormal)
                                    .foregroundColor(AppTheme.colorTexto)
                            }
                        }


                    }

                    // Botón principal
                    Button(action: guardarContrato) {
                        Label("Guardar Contrato", systemImage: "doc.text.magnifyingglass")
                            .font(AppTheme.fuenteNormal.weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.colorResaltado)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 3)
                            .scaleEffect(animar ? 1.05 : 1.0)
                            .animation(.spring(), value: animar)
                    }

                    Divider()
                        .background(AppTheme.colorTexto.opacity(0.4))
                        .padding(.vertical, 10)

                    // Lista de contratos
                    if contratos.isEmpty {
                        Text("No hay contratos creados")
                            .foregroundColor(AppTheme.colorTexto.opacity(0.6))
                            .font(AppTheme.fuenteNormal)
                    } else {
                        VStack(spacing: 12) {
                            ForEach(contratos) { contrato in
                                HStack(alignment: .top, spacing: 10) {
                                    Image(systemName: "signature")
                                        .font(.system(size: 36))
                                        .foregroundColor(AppTheme.colorResaltado)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(contrato.cliente)
                                            .font(AppTheme.fuenteSubtitulo)
                                            .foregroundColor(AppTheme.colorTexto)
                                        Text(contrato.servicio)
                                            .font(AppTheme.fuenteNormal)
                                        Text("Duración: \(contrato.duracion) meses")
                                            .font(AppTheme.fuentePequena)
                                            .foregroundColor(AppTheme.colorTexto.opacity(0.6))
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(AppTheme.colorFondo.opacity(0.4))
                                .cornerRadius(10)
                            }
                            .onDelete(perform: eliminarContrato)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear(perform: loadContratos)
        .navigationTitle("Contratos")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Funciones de datos
    func guardarContrato() {
        guard !cliente.isEmpty, !servicio.isEmpty else { return }
        withAnimation {
            let contrato = Contrato(cliente: cliente, servicio: servicio, duracion: duracion, condiciones: condiciones)
            contratos.append(contrato)
            saveContratos()
            cliente = ""; servicio = ""; duracion = ""; condiciones = ""
            animar = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { animar = false }
    }

    func eliminarContrato(at offsets: IndexSet) {
        withAnimation {
            contratos.remove(atOffsets: offsets)
            saveContratos()
        }
    }

    func saveContratos() {
        if let data = try? JSONEncoder().encode(contratos) {
            contratosData = data
        }
    }

    func loadContratos() {
        if let decoded = try? JSONDecoder().decode([Contrato].self, from: contratosData) {
            contratos = decoded
        }
    }
}

// MARK: - CampoTexto Reutilizable
struct CampoTexto: View {
    var placeholder: String
    @Binding var texto: String
    var esSeguro: Bool = false  // 👈 nuevo parámetro opcional

    var body: some View {
        Group {
            if esSeguro {
                SecureField(placeholder, text: $texto)
            } else {
                TextField(placeholder, text: $texto)
            }
        }
        .padding()
        .background(AppTheme.colorFondo.opacity(0.3))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppTheme.colorSecundario.opacity(0.4), lineWidth: 1)
        )
        .font(AppTheme.fuenteNormal)
        .foregroundColor(AppTheme.colorTexto)
    }
}


#Preview {
    NavigationView {
        ContratoView()
    }
}
