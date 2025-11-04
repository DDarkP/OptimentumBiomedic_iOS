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

struct InventarioView: View {
    @AppStorage("inventario") private var inventarioData: Data = Data()
    @State private var inventario: [Equipo] = []

    @State private var nombre = ""
    @State private var cantidad = ""
    @State private var ubicacion = ""
    @State private var animar = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Inventario de Equipos")
                .font(.title2).bold().padding(.top, 10)

            TextField("Nombre del equipo", text: $nombre)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Cantidad", text: $cantidad)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Ubicación", text: $ubicacion)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: agregarEquipo) {
                Label("Agregar Equipo", systemImage: "wrench.and.screwdriver.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.4))
                    .cornerRadius(10)
                    .scaleEffect(animar ? 1.05 : 1.0)
                    .animation(.spring(), value: animar)
            }

            Divider().padding(.vertical, 10)

            if inventario.isEmpty {
                Text("Sin equipos registrados").foregroundColor(.gray)
            } else {
                List {
                    ForEach(inventario) { eq in
                        HStack {
                            Image(systemName: "cube.box.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.blue)
                            VStack(alignment: .leading) {
                                Text(eq.nombre).font(.headline)
                                Text("Cantidad: \(eq.cantidad)")
                                Text("Ubicación: \(eq.ubicacion)").font(.footnote)
                            }
                        }
                    }.onDelete(perform: eliminarEquipo)
                }
            }
        }
        .padding()
        .onAppear(perform: loadInventario)
        .navigationTitle("Inventario")
    }

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
        withAnimation { inventario.remove(atOffsets: offsets); saveInventario() }
    }

    func saveInventario() {
        if let data = try? JSONEncoder().encode(inventario) { inventarioData = data }
    }
    func loadInventario() {
        if let decoded = try? JSONDecoder().decode([Equipo].self, from: inventarioData) { inventario = decoded }
    }
}

#Preview {
    InventarioView()
}
