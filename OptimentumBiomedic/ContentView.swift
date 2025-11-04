//
//  ContentView.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 1/11/25.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationStack { // Usamos NavigationStack para navegación moderna
            LoginView()
        }
    }
}

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var navegarADetalles = false
    
    
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 2) {
                Text("Bienvenido")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Ingeniero")
                    .font(.title2)
                    .fontWeight(.bold)
            }

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            SecureField("Contraseña", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            // Botón para iniciar sesión que navega programáticamente
            Button(action: {
                if !email.isEmpty && !password.isEmpty {
                    navegarADetalles = true
                }
            }) {
                Text("Iniciar sesión")
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                        }

            // Navegación hacia la pantalla después de iniciar sesión
            NavigationLink("", destination: PantallaMenu(), isActive: $navegarADetalles)

            Button("¿Olvidaste tu contraseña?") {
                // Coloca aquí la lógica para recuperar contraseña
            }
            .foregroundColor(.blue)

            NavigationLink("Registro", destination: RegisterView())
                .underline()
                .padding(.top)
        }
        .padding()
        
    }
}

//struct PantallaDetalleView: View {
  //  var body: some View {
    //    Text("Pantalla después de iniciar sesión")
      //      .font(.largeTitle)
        //    .padding()
   // }
//}//

struct RegisterView: View {
    @State private var nombres = ""
    @State private var apellidos = ""
    @State private var correo = ""
    @State private var password = ""
    @State private var navegarAMenu = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Registro")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Nombres", text: $nombres)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            TextField("Apellidos", text: $apellidos)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            TextField("Correo", text: $correo)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            SecureField("Contraseña", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            
            
            Button(action: {
                // Lógica para registrar usuario
            }) {
                                 
                
                NavigationLink("", destination: PantallaMenu(), isActive: $navegarAMenu)
                
                NavigationLink("Registrar", destination: PantallaMenu())
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(12).underline()
                    .padding(.top)
            }
        }
        .padding()
    }
}
struct PantallaMenu: View {
    @State private var realizarhojasdevida = ""
    @State private var cotizacion = ""
    @State private var inventario = ""
    @State private var contrato = ""
    @State private var navegarHojaDeVida = false
    @State private var navegarCotización = false
    @State private var navegarInventario = false
    @State private var navegarContrato = false
    var body: some View {
      
        VStack(spacing: 20) {
            Image(systemName: "wrench.fill") // Aquí coloca tu logo como Image("nombreLogo") si tienes en assets
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding()

            Text("OPTIMENTUM BIOMEDIC")
                .font(.headline)
                .bold()

            Spacer().frame(height: 15)

            Text("Bienvenido, Inge")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("¿Qué deseas hacer hoy?")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer().frame(height: 25)

            VStack(spacing: 10) {
                Button(action: {}) {
                    NavigationLink("", destination: HojaDeVidaView(), isActive: $navegarHojaDeVida)
                    
                    NavigationLink("REALIZAR HOJAS DE VIDA", destination: HojaDeVidaView())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.4))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .font(.headline)
                }

                Button(action: {}) {
                    
                    NavigationLink("", destination: CotizacionView(), isActive: $navegarCotización)
                    
                    NavigationLink("COTIZACIONES", destination: CotizacionView())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.3))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .font(.headline)
                }

                Button(action: {}) {
                    NavigationLink("", destination: InventarioView(), isActive: $navegarInventario)
                   
                    NavigationLink("INVENTARIO DE EQUIPOS", destination:InventarioView())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.4))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .font(.headline)
                }

                Button(action: {}) {
                    NavigationLink("", destination: ContratoView(), isActive: $navegarContrato)
                    
                    NavigationLink ("CONTRATO", destination: ContratoView())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.3))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .font(.headline)
                }
            }
            .padding()

            Spacer()
        }
        .padding()
        .background(Color(red: 245/255, green: 240/255, blue: 238/255))
    }
}
struct HojaDeVidaView: View {
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
        VStack {
            if pagina == 1 {
                // --- Primera pantalla ---
                VStack(alignment: .center, spacing: 10){
                    HStack {
                    Text("HOJA DE VIDA")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 18)
                        .padding(.leading, 3)
                        .font(.title)
                        
                    TextField("Nombre del equipo", text: $nombredelequipo)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    Text("INFORMACION GENERAL")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color(red: 135/255, green: 206/255, blue: 250/255))
                        .cornerRadius(12)
                    
                    TextField("Digite aquí la descripción del equipo", text: $descripcion)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)

                    VStack(alignment: .leading) {
                        Text("MARCA")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.body)
                        
                        TextField("Digite aquí la marca del equipo", text: $marca)
                            .padding()
                            .background(Color(red: 135/255, green: 206/255, blue: 250/255))
                                .cornerRadius(16)
                                .foregroundColor(.white)
                    }

                    VStack(alignment: .leading) {
                        Text("MODELO")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .fontWeight(.bold)
                            .font(.body)
                        
                        TextField("Digite aquí el modelo del equipo", text: $modelo)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(16)
                    }

                    VStack(alignment: .leading) {
                        Text("SERIE")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .fontWeight(.bold)
                            .font(.body)
                        
                        TextField("Digite aquí la serie del equipo", text: $serie)
                            .padding()
                            .background(Color(red: 135/255, green: 206/255, blue: 250/255))
                                .cornerRadius(16)
                                .foregroundColor(.white)
                    }
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            pagina = 2
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.teal)
                        }
                        .padding([.bottom,.trailing], 12)
                    }
                }
                .padding()
                .background(Color(red: 26/255, green: 64/255, blue: 74/255))
                .edgesIgnoringSafeArea(.bottom)
            } else {
                // --- Segunda pantalla ---
                VStack(spacing: 22) {
                    
                    Text("HOJA DE VIDA")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 18)
                        .padding(.leading, 3)
                    
                    Text("REGISTRO TECNICO")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color(.systemGreen).opacity(0.34))
                        .cornerRadius(12)
                    
                    Text("CLASIFICACIÓN DE RIESGO ELÉCTRICO")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, -8)
                  
                    HStack {
                    Picker("Escoja la clase...", selection: $claseRiesgo1) {
                        ForEach(clases, id: \.self) { valor in
                            Text(valor)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    
                    Picker("Escoja el tipo...", selection: $claseTipos) {
                        ForEach(tipos, id: \.self) { valor in
                            Text(valor)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        Text("VOLTAJES DE OPERACION")
                            .foregroundColor(.white)
                        HStack {
                            TextField("MAX", text: $voltajeMax)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            TextField("MIN", text: $voltajeMin)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("CORRIENTES DE OPERACION")
                            .foregroundColor(.white)
                        HStack {
                            TextField("MAX", text: $corrienteMax)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            TextField("MIN", text: $corrienteMin)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                        }
                    }

                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            // Aquí puedes agregar la funcionalidad de guardar
                        }) {
                            Image(systemName: "paperplane.fill")
                                .font(.title2)
                                .foregroundColor(.teal)
                        }
                        .padding([.bottom,.trailing], 12)
                    }
                }
                .padding()
                .background(Color(red: 26/255, green: 64/255, blue: 74/255))
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}
struct InventarioView: View {
    @State private var descripcion = ""
    @State private var marca = ""
    @State private var modelo = ""
    @State private var serie = ""

    var body: some View {
        VStack(spacing: 22) {
            // Encabezado superior
            HStack {
                Text("NOMBRE DEL EQUIPO")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                VStack {
                    Image(systemName: "leaf") // Puedes cambiar por el logo de tu marca
                        .resizable().frame(width: 32, height: 32)
                        .foregroundColor(.white)
                    Text("\"NOMBRE DEL EQUIPO\"")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .padding(.top, 16)

            // Título de sección principal
            Text("REGISTRAR DATOS")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color(.systemGreen).opacity(0.34))
                .cornerRadius(12)
                .padding(.bottom, 8)

            // Campo: Descripción
            TextField("Digite aquí la descripción del equipo", text: $descripcion)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)

            // Campo: Marca
            VStack(alignment: .leading, spacing: 4) {
                Text("MARCA")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.body)
                
                TextField("Digite aquí la marca del equipo", text: $marca)
                    .padding()
                    .background(Color(red: 135/255, green: 206/255, blue: 250/255))
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }

            // Campo: Modelo
            VStack(alignment: .leading, spacing: 4) {
                Text("MODELO")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.body)
                
                TextField("Digite aquí el modelo del equipo", text: $modelo)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
            }

            // Campo: Serie
            VStack(alignment: .leading, spacing: 4) {
                Text("SERIE")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.body)
                
                TextField("Digite aquí la serie del equipo", text: $serie)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color(red: 135/255, green: 206/255, blue: 250/255))
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }

            Spacer()
            
            // Botón siguiente (puedes cambiar el icono por texto o agregar acción de navegación)
            HStack {
                Spacer()
                Button(action: {
                    // Acción: Ir a siguiente pantalla
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.teal)
                }
                .padding([.bottom, .trailing], 10)
            }
        }
        .padding()
        .background(Color(red: 26/255, green: 64/255, blue: 74/255))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct CotizacionView: View {
    @State private var nombreEmpresa: String = ""
    @State private var cantidad: String = ""
    @State private var mostrarOpciones: Bool = false
    @State private var listaCantidades = ["1", "2", "3", "4", "5"]
    @State private var valorEquipo: String = ""
    @State private var valorMantenimiento1: String = ""
    @State private var nombredelequipo2 = ""

    // Ahora total solo multiplica cantidad * (valorEquipo + valorMantenimiento1)
    var total: Double {
        let cant = Double(cantidad) ?? 0
        let valorEquip = Double(valorEquipo) ?? 0
        let valorMant = Double(valorMantenimiento1) ?? 0
        return (valorEquip + valorMant) * cant
    }

    var body: some View {
        VStack(spacing: 20) {
            // Encabezado y Logo
            VStack(spacing: 2) {
                Text("COTIZACION")
                    .font(.headline)
                    .foregroundColor(.white)
                TextField("Escriba el nombre del equipo", text: $nombredelequipo2)
                    .font(.body)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.top, 16)

            TextField("NOMBRE DE LA EMPRESA O PERSONA DE LA COTIZACION", text: $nombreEmpresa)
                .font(.footnote)
                .padding()
                .background(Color(red: 135/255, green: 206/255, blue: 250/255))
                .cornerRadius(10)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            VStack(alignment: .leading, spacing: 8) {
                Text("CANTIDAD")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.body)

                ZStack {
                    TextField("Escoja la cantidad...", text: $cantidad)
                        .disabled(true)
                        .font(.body)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    HStack {
                        Spacer()
                        Button(action: { mostrarOpciones.toggle() }) {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 16)
                    }
                }

                if mostrarOpciones {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(listaCantidades, id: \.self) { item in
                            Button(item) {
                                cantidad = item
                                mostrarOpciones = false
                            }
                            .foregroundColor(.black)
                        }
                    }
                    .background(Color(.systemGray4))
                    .cornerRadius(10)
                }
            }

            Group {
                Text("VALOR DEL EQUIPO")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.body)

                TextField("Escriba el valor...", text: $valorEquipo)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(red: 135/255, green: 206/255, blue: 250/255))
                    .cornerRadius(10)
                    .foregroundColor(.white)

                Text("VALOR DEL MANTENIMIENTO")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.body)

                TextField("Escriba el valor...", text: $valorMantenimiento1)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .foregroundColor(.black)
            }

            Text("Total: \(total, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.white)
                .padding()

            Spacer()

            HStack {
                Image(systemName: "house.fill")
                Spacer()
                Image(systemName: "person.fill")
                Spacer()
                Image(systemName: "plus.circle.fill")
            }
            .foregroundColor(.teal)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
        .padding()
        .background(Color(red: 26/255, green: 64/255, blue: 74/255))
        .edgesIgnoringSafeArea(.bottom)
    }
}
struct ContratoView: View {
    @State private var fechaInicio: Date = Date()
    @State private var fechaFin: Date = Date()
    @State private var valorContrato: String = ""
    @State private var formaPago: String = ""
    @State private var objetoPropuesta: String = ""
    @State private var mostrarInicio: Bool = false
    @State private var mostrarFin: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            // Encabezado
            VStack(spacing: 2) {
                Text("CONTRATO")
                    .font(.headline)
                    .foregroundColor(.white)
                    .underline()
            }
            .padding(.top, 16)
            
            // Fechas: Horizontal stack
            VStack(alignment: .leading, spacing: 8) {
                Text("TIEMPO DE CONTRATO")
                    .foregroundColor(.white)
                HStack(spacing: 10) {
                    Button(action: { mostrarInicio.toggle() }) {
                        Text("Fecha inicio")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .foregroundColor(.gray)
                            .cornerRadius(20)
                    }
                    .sheet(isPresented: $mostrarInicio) {
                        VStack {
                            DatePicker("Fecha inicio", selection: $fechaInicio, displayedComponents: .date)
                                .datePickerStyle(.graphical)
                            Button("Cerrar") { mostrarInicio = false }
                        }.padding()
                    }
                    
                    Button(action: { mostrarFin.toggle() }) {
                        Text("Fecha Fin")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .foregroundColor(.gray)
                            .cornerRadius(20)
                    }
                    .sheet(isPresented: $mostrarFin) {
                        VStack {
                            DatePicker("Fecha Fin", selection: $fechaFin, displayedComponents: .date)
                                .datePickerStyle(.graphical)
                            Button("Cerrar") { mostrarFin = false }
                        }.padding()
                    }
                }
            }

            // Valor de contrato
            VStack(alignment: .leading) {
                Text("VALOR DE CONTRATO...")
                    .foregroundColor(.white)
                TextField("Escriba el valor", text: $valorContrato)
                    .padding()
                    .background(Color(.systemTeal).opacity(0.6))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }

            // Forma de pago
            VStack(alignment: .leading) {
                Text("FORMA DE PAGO")
                    .foregroundColor(.white)
                TextField("Escriba la forma de pago", text: $formaPago)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .foregroundColor(.gray)
            }

            // Objeto de la propuesta
            VStack(alignment: .leading) {
                Text("OBJETO DE LA PROPUESTA")
                    .foregroundColor(.white)
                TextEditor(text: $objetoPropuesta)
                    .frame(height: 80)
                    .background(Color(.systemGray6))
                    .cornerRadius(14)
                    .foregroundColor(.gray)
                    .padding(.top, 2)
            }

            Spacer()
            
            // Barra de navegación inferior simulada
            HStack {
                Image(systemName: "house.fill")
                Spacer()
                Image(systemName: "person.fill")
                Spacer()
                
            }
            .foregroundColor(.teal)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
        .padding()
        .background(Color(red: 26/255, green: 64/255, blue: 74/255))
        .edgesIgnoringSafeArea(.bottom)
    }
}
