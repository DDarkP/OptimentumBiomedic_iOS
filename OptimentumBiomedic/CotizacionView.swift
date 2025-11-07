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
        ZStack {
            // Fondo degradado
            AppTheme.gradientePrincipal
                .ignoresSafeArea()

            VStack(spacing: 25) {
                // Título
                Text("Generar Cotización")
                    .font(AppTheme.fuenteTitulo)
                    .foregroundColor(AppTheme.colorPrimario)
                    .padding(.top, 10)

                // Campos de texto
                VStack(spacing: 15) {
                    CampoTexto(placeholder: "Cliente", texto: $cliente)
                    CampoTexto(placeholder: "Descripción", texto: $descripcion)
                    CampoTexto(placeholder: "Valor ($)", texto: $valor)
                }

                // Botón de guardar
                Button(action: guardarCotizacion) {
                    Label("Guardar Cotización", systemImage: "doc.text.fill")
                        .font(AppTheme.fuenteNormal)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(AppTheme.colorResaltado)
                        .cornerRadius(10)
                        .shadow(color: AppTheme.colorPrimario.opacity(0.4), radius: 5, x: 0, y: 3)
                        .scaleEffect(animarBoton ? 1.05 : 1.0)
                        .animation(.spring(), value: animarBoton)
                }

                Divider()
                    .background(AppTheme.colorTexto.opacity(0.3))
                    .padding(.vertical, 10)

                // Lista de cotizaciones
                if cotizaciones.isEmpty {
                    Text("No hay cotizaciones aún")
                        .foregroundColor(AppTheme.colorTexto.opacity(0.7))
                        .font(AppTheme.fuenteNormal)
                } else {
                    List {
                        ForEach(cotizaciones) { cot in
                            HStack {
                                Image(systemName: "dollarsign.circle.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(AppTheme.colorSecundario)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(cot.cliente)
                                        .font(AppTheme.fuenteSubtitulo)
                                    Text(cot.descripcion)
                                        .font(AppTheme.fuenteNormal)
                                    Text("$\(cot.valor)")
                                        .font(AppTheme.fuentePequena)
                                        .foregroundColor(AppTheme.colorSecundario)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                        .onDelete(perform: eliminarCotizacion)
                    }
                    .scrollContentBackground(.hidden)
                    .background(AppTheme.colorFondo.opacity(0.2))
                }
            }
            .padding()
            .onAppear(perform: loadCotizaciones)
            .navigationTitle("Cotizaciones")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Lógica de cotizaciones
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
        withAnimation {
            cotizaciones.remove(atOffsets: offsets)
            saveCotizaciones()
        }
    }

    func saveCotizaciones() {
        if let data = try? JSONEncoder().encode(cotizaciones) {
            cotizacionesData = data
        }
    }

    func loadCotizaciones() {
        if let decoded = try? JSONDecoder().decode([Cotizacion].self, from: cotizacionesData) {
            cotizaciones = decoded
        }
    }
}

#Preview {
    CotizacionView()
}
