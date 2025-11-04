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
        VStack(spacing: 20) {
            Text("📜 Generar Contrato")
                .font(.title2).bold().padding(.top, 10)
            
            TextField("Cliente", text: $cliente)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Servicio", text: $servicio)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Duración (meses)", text: $duracion)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextEditor(text: $condiciones)
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))

            Button(action: guardarContrato) {
                Label("Guardar Contrato", systemImage: "doc.text.magnifyingglass")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple.opacity(0.4))
                    .cornerRadius(10)
                    .scaleEffect(animar ? 1.05 : 1.0)
                    .animation(.spring(), value: animar)
            }

            Divider().padding(.vertical, 10)

            if contratos.isEmpty {
                Text("No hay contratos creados").foregroundColor(.gray)
            } else {
                List {
                    ForEach(contratos) { contrato in
                        HStack {
                            Image(systemName: "signature")
                                .font(.system(size: 36))
                                .foregroundColor(.purple)
                            VStack(alignment: .leading) {
                                Text(contrato.cliente).font(.headline)
                                Text(contrato.servicio)
                                Text("Duración: \(contrato.duracion) meses")
                                    .font(.footnote).foregroundColor(.gray)
                            }
                        }
                    }.onDelete(perform: eliminarContrato)
                }
            }
        }
        .padding()
        .onAppear(perform: loadContratos)
        .navigationTitle("Contratos")
    }

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
        withAnimation { contratos.remove(atOffsets: offsets); saveContratos() }
    }

    func saveContratos() {
        if let data = try? JSONEncoder().encode(contratos) { contratosData = data }
    }
    func loadContratos() {
        if let decoded = try? JSONDecoder().decode([Contrato].self, from: contratosData) { contratos = decoded }
    }
}

#Preview {
    ContratoView()
}
