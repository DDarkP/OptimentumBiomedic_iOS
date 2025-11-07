//
//  InventarioView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//

import SwiftUI

struct Equipo: Identifiable, Codable {
    let id = UUID()
    var nombre: String
    var cantidad: String
    var ubicacion: String
}
import SwiftUI

struct InventarioView: View {
    @AppStorage("inventario") private var inventarioData: Data = Data()
    @State private var inventario: [Equipo] = []

    @State private var nombre = ""
    @State private var cantidad = ""
    @State private var ubicacion = ""
    @State private var animar = false

    var body: some View {
        ZStack {
            // Fondo con gradiente del tema
            AppTheme.gradientePrincipal
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Título
                    Text("Inventario de Equipos")
                        .font(AppTheme.fuenteTitulo)
                        .foregroundColor(AppTheme.colorTexto)
                        .padding(.top, 10)

                    // Campos de texto con el tema
                    CampoTexto(placeholder: "Nombre del equipo", texto: $nombre)
                    CampoTexto(placeholder: "Cantidad", texto: $cantidad)
                    CampoTexto(placeholder: "Ubicación", texto: $ubicacion)

                    // Botón agregar
                    Button(action: agregarEquipo) {
                        Label("Agregar Equipo", systemImage: "wrench.and.screwdriver.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.colorResaltado.opacity(0.8))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .font(AppTheme.fuenteSubtitulo)
                            .shadow(radius: 3)
                            .scaleEffect(animar ? 1.05 : 1.0)
                            .animation(.spring(), value: animar)
                    }

                    Divider().background(AppTheme.colorTexto.opacity(0.4)).padding(.vertical, 10)

                    // Lista o mensaje vacío
                    if inventario.isEmpty {
                        Text("Sin equipos registrados")
                            .foregroundColor(AppTheme.colorTexto.opacity(0.7))
                            .font(AppTheme.fuenteNormal)
                            .padding(.top, 10)
                    } else {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(inventario) { eq in
                                HStack(spacing: 15) {
                                    Image(systemName: "cube.box.fill")
                                        .font(.system(size: 36))
                                        .foregroundColor(AppTheme.colorSecundario)

                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(eq.nombre)
                                            .font(AppTheme.fuenteSubtitulo)
                                            .foregroundColor(AppTheme.colorTexto)
                                        Text("Cantidad: \(eq.cantidad)")
                                            .font(AppTheme.fuenteNormal)
                                            .foregroundColor(AppTheme.colorTexto.opacity(0.9))
                                        Text("Ubicación: \(eq.ubicacion)")
                                            .font(AppTheme.fuentePequena)
                                            .foregroundColor(AppTheme.colorTexto.opacity(0.8))
                                    }
                                }
                                .padding()
                                .background(AppTheme.colorFondo.opacity(0.8))
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                            }
                            .onDelete(perform: eliminarEquipo)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear(perform: loadInventario)
        .navigationTitle("Inventario")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Funciones de almacenamiento
    func agregarEquipo() {
        guard !nombre.isEmpty, !cantidad.isEmpty else { return }
        withAnimation {
            let eq = Equipo(nombre: nombre, cantidad: cantidad, ubicacion: ubicacion)
            inventario.append(eq)
            saveInventario()
            nombre = ""; cantidad = ""; ubicacion = ""
            animar = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { animar = false }
    }

    func eliminarEquipo(at offsets: IndexSet) {
        withAnimation {
            inventario.remove(atOffsets: offsets)
            saveInventario()
        }
    }

    func saveInventario() {
        if let data = try? JSONEncoder().encode(inventario) {
            inventarioData = data
        }
    }

    func loadInventario() {
        if let decoded = try? JSONDecoder().decode([Equipo].self, from: inventarioData) {
            inventario = decoded
        }
    }
}


#Preview {
    InventarioView()
}
