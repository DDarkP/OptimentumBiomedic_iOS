//
//  CotizacionView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//
import SwiftUI

struct Cotizacion: Identifiable, Codable {
    let id = UUID()
    var cliente: String
    var descripcion: String
    var valor: String
}

struct CotizacionView: View {
    @AppStorage("cotizaciones") private var cotizacionesData: Data = Data()
    @State private var cotizaciones: [Cotizacion] = []
    
    @State private var cliente = ""
    @State private var descripcion = ""
    @State private var valor = ""
    @State private var animarBoton = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Generar Cotización")
                .font(.title2).bold().padding(.top, 10)
            
            TextField("Cliente", text: $cliente)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Descripción", text: $descripcion)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Valor ($)", text: $valor)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: guardarCotizacion) {
                Label("Guardar Cotización", systemImage: "doc.text.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange.opacity(0.4))
                    .cornerRadius(10)
                    .scaleEffect(animarBoton ? 1.05 : 1.0)
                    .animation(.spring(), value: animarBoton)
            }

            Divider().padding(.vertical, 10)

            if cotizaciones.isEmpty {
                Text("No hay cotizaciones aún").foregroundColor(.gray)
            } else {
                List {
                    ForEach(cotizaciones) { cot in
                        HStack {
                            Image(systemName: "dollarsign.circle.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.green)
                            VStack(alignment: .leading) {
                                Text(cot.cliente).font(.headline)
                                Text(cot.descripcion)
                                Text("$\(cot.valor)").foregroundColor(.green)
                            }
                        }
                    }.onDelete(perform: eliminarCotizacion)
                }
            }
        }
        .padding()
        .onAppear(perform: loadCotizaciones)
        .navigationTitle("Cotizaciones")
    }

    func guardarCotizacion() {
        guard !cliente.isEmpty, !valor.isEmpty else { return }
        withAnimation {
            let cot = Cotizacion(cliente: cliente, descripcion: descripcion, valor: valor)
            cotizaciones.append(cot)
            saveCotizaciones()
            cliente = ""; descripcion = ""; valor = ""
            animarBoton = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { animarBoton = false }
    }

    func eliminarCotizacion(at offsets: IndexSet) {
        withAnimation { cotizaciones.remove(atOffsets: offsets); saveCotizaciones() }
    }

    func saveCotizaciones() {
        if let data = try? JSONEncoder().encode(cotizaciones) { cotizacionesData = data }
    }
    func loadCotizaciones() {
        if let decoded = try? JSONDecoder().decode([Cotizacion].self, from: cotizacionesData) { cotizaciones = decoded }
    }
}


#Preview {
    CotizacionView()
}
