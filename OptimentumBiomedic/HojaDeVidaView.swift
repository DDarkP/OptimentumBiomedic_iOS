//
//  HojaDeVidaView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//
import SwiftUI

struct HojaDeVida: Identifiable, Codable {
    let id = UUID()
    var nombre: String
    var cargo: String
    var experiencia: String
}

struct HojaDeVidaView: View {
    @AppStorage("hojasDeVida") private var hojasData: Data = Data()
    @State private var hojas: [HojaDeVida] = []
    
    @State private var nombre = ""
    @State private var cargo = ""
    @State private var experiencia = ""
    @State private var mostrarAnimacion = false

    var body: some View {
        VStack(spacing: 20) {
            Text("🧾 Realizar Hoja de Vida")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 10)

            Group {
                TextField("Nombre completo", text: $nombre)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Cargo", text: $cargo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextEditor(text: $experiencia)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
            }

            Button(action: agregarHoja) {
                Label("Guardar", systemImage: "tray.and.arrow.down.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green.opacity(0.4))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .font(.headline)
                    .scaleEffect(mostrarAnimacion ? 1.05 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: mostrarAnimacion)
            }

            Divider().padding(.vertical, 10)
            
            if hojas.isEmpty {
                Text("Aún no hay hojas de vida registradas")
                    .foregroundColor(.gray)
                    .transition(.opacity)
            } else {
                List {
                    ForEach(hojas) { hoja in
                        HStack(alignment: .top) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(hoja.nombre).font(.headline)
                                Text(hoja.cargo).foregroundColor(.gray)
                                Text(hoja.experiencia)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 5)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    .onDelete(perform: eliminarHoja)
                }
                .listStyle(.insetGrouped)
            }
        }
        .padding()
        .onAppear(perform: loadHojas)
        .navigationTitle("Hojas de Vida")
    }
    
    func agregarHoja() {
        guard !nombre.isEmpty, !cargo.isEmpty else { return }
        withAnimation(.spring()) {
            let hoja = HojaDeVida(nombre: nombre, cargo: cargo, experiencia: experiencia)
            hojas.append(hoja)
            saveHojas()
            nombre = ""; cargo = ""; experiencia = ""
            mostrarAnimacion = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            mostrarAnimacion = false
        }
    }
    
    func eliminarHoja(at offsets: IndexSet) {
        withAnimation {
            hojas.remove(atOffsets: offsets)
            saveHojas()
        }
    }

    func saveHojas() {
        if let data = try? JSONEncoder().encode(hojas) {
            hojasData = data
        }
    }

    func loadHojas() {
        if let decoded = try? JSONDecoder().decode([HojaDeVida].self, from: hojasData) {
            hojas = decoded
        }
    }
}


#Preview {
    HojaDeVidaView()
}
