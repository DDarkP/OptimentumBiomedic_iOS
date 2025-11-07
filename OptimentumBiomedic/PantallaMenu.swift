
import SwiftUI

struct PantallaMenu: View {
    @EnvironmentObject var auth: AuthManager
    @Environment(\.dismiss) var dismiss
    @State private var mostrarConfirmacion = false

    var body: some View {
        VStack(spacing: 25) {
            // Logo institucional
            Image("LOGO")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding(.top, 40)

            // Bienvenida personalizada
            if let usuario = auth.usuarioActual {
                Text("Bienvenido, Ingeniero \(usuario.nombre)")
                    .font(AppTheme.fuenteSubtitulo)
                    .foregroundColor(AppTheme.colorTexto)
            } else {
                Text("Bienvenido")
                    .font(AppTheme.fuenteSubtitulo)
                    .foregroundColor(AppTheme.colorTexto)
            }

            Text("¿Qué deseas hacer hoy?")
                .font(AppTheme.fuenteNormal)
                .foregroundColor(AppTheme.colorTexto.opacity(0.7))

            Spacer().frame(height: 30)

            // Opciones del menú
            VStack(spacing: 12) {
                NavigationLink("REALIZAR HOJAS DE VIDA", destination: HojaDeVidaView())
                    .buttonStyle(MenuButtonStyle(color: AppTheme.colorResaltado.opacity(0.9)))

                NavigationLink("COTIZACIONES", destination: CotizacionView())
                    .buttonStyle(MenuButtonStyle(color: AppTheme.colorResaltado.opacity(0.85)))

                NavigationLink("INVENTARIO DE EQUIPOS", destination: InventarioView())
                    .buttonStyle(MenuButtonStyle(color: AppTheme.colorResaltado.opacity(0.9)))

                NavigationLink("CONTRATO", destination: ContratoView())
                    .buttonStyle(MenuButtonStyle(color: AppTheme.colorResaltado.opacity(0.85)))

                NavigationLink("CRÉDITOS", destination: CreditosView())
                    .buttonStyle(MenuButtonStyle(color: AppTheme.colorResaltado.opacity(0.85)))
            }
            .padding(.horizontal)

            Spacer()

            // Botón de cerrar sesión
            Button(action: {
                mostrarConfirmacion = true
            }) {
                Text("Cerrar sesión")
                    .font(AppTheme.fuenteNormal.weight(.semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.9))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 3)
            }
            .padding(.horizontal)
            .confirmationDialog(
                "¿Seguro que deseas cerrar sesión?",
                isPresented: $mostrarConfirmacion,
                titleVisibility: .visible
            ) {
                Button("Cerrar sesión", role: .destructive) {
                    withAnimation(.easeInOut) {
                        auth.logout()
                        dismiss()
                    }
                }
                Button("Cancelar", role: .cancel) { }
            }
        }
        .padding()
        .background(AppTheme.gradientePrincipal.ignoresSafeArea())
    }
}

// MARK: - Estilo personalizado de botones del menú
struct MenuButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTheme.fuenteNormal.weight(.semibold))
            .foregroundColor(AppTheme.colorTexto)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    NavigationView {
        PantallaMenu()
            .environmentObject(AuthManager())
    }
}
