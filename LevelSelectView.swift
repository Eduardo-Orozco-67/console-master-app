import SwiftUI

struct LevelSelectView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedLevel: Int?
    @State private var isLevelSelected: Bool = false

    let levelInfo: [Int: (name: String, detail: String)] = [
        1: ("ls", "List directory contents. 'ls' for 'list'."),
        2: ("cd", "Change directory. 'cd' for 'change directory'."),
        3: ("touch", "Create a new file or update the timestamp. 'touch' to create/update files."),
        4: ("rm", "Remove files or directories. 'rm' for 'remove'."),
        5: ("cp", "Copy files or directories. 'cp' for 'copy'."),
        6: ("mv", "Move or rename files or directories. 'mv' for 'move'."),
        7: ("cat", "Concatenate and display files. 'cat' to view file contents."),
        8: ("mkdir", "Create a new directory. 'mkdir' for 'make directory'."),
        9: ("rmdir", "Remove empty directories. 'rmdir' for 'remove directory'."),
        10: ("chmod", "Change file mode bits. 'chmod' for changing permissions.")
    ]

    var body: some View {
           NavigationView {
               ZStack {
                   LinearGradient(gradient: Gradient(colors: [Color(red: 0.16, green: 0.17, blue: 0.21), Color(red: 0.09, green: 0.10, blue: 0.13)]), startPoint: .top, endPoint: .bottom)
                       .edgesIgnoringSafeArea(.all)
                   
                   VStack {
                       backButton
                           .padding(.top, 30)
                           .padding(.leading, 20)
                           .alignmentGuide(.leading) { d in d[.leading] }
                           .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                       
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack(spacing: 20) {
                               ForEach(levelInfo.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                   LevelButtonView(level: key, commandName: value.name, commandDetail: value.detail, action: {
                                       self.selectedLevel = key
                                       self.isLevelSelected = true
                                   })
                               }
                           }
                           .padding(.vertical, 80)
                           .padding(.horizontal, 20)
                       }
                       
                       // Esta es la parte clave para la navegación programática
                       NavigationLink("", destination: destinationView(for: selectedLevel), isActive: $isLevelSelected)
                   }
               }
           }
       }
       
       private var backButton: some View {
           Button(action: {
               dismiss()
           }) {
               HStack {
                   Image(systemName: "chevron.left.circle.fill")
                       .foregroundColor(.green)
                       .font(.largeTitle)
                   Text("Back")
                       .foregroundColor(.green)
                       .font(.system(size: 30))
               }
           }.buttonStyle(PlainButtonStyle())
       }
       
       @ViewBuilder
       private func destinationView(for level: Int?) -> some View {
           switch level {
           case 1:
               Level1View()
           case 2:
               Level2View()
           case 3:
               Level3View()
           case 4:
               Level4View()
           case 5:
               Level5View()
           case 6:
               Level6View()
           case 7:
               Level7View()
           case 8:
               Level8View()
           case 9:
               Level9View()
           case 10:
               Level10View(isShowingLevel10: .constant(false))
           // Agrega aquí el resto de tus casos de nivel
           default:
               Text("Level not found")
           }
       }
}
struct LevelButtonView: View {
    let level: Int
    let commandName: String
    let commandDetail: String
    var action: () -> Void // Añade la capacidad de ejecutar una acción

    var body: some View {
        Button(action: action) { // Ejecuta el bloque de acción aquí
            ZStack {
                // Fondo translúcido con el comando
                TypingText(text: commandName, speed: 0.5, pauseDuration: 0.5)
                    .blur(radius: 5)

                // Contenido principal
                VStack(alignment: .leading) {
                    Text("Level \(level): \(commandName.uppercased())")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .padding(5)
                    Text(commandDetail)
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .padding(5)
                }
            }
            .frame(width: 400, height: 550)
            .background(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.6), Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle()) // Estilo del botón para evitar estilos predeterminados
    }
}


struct TypingText: View {
    let text: String
    let speed: TimeInterval // Velocidad de "escritura"
    let pauseDuration: TimeInterval // Duración de la pausa al final

    @State private var visibleText: String = ""
    @State private var counter: Int = 0
    @State private var timer: Timer?
    @State private var isPaused: Bool = false

    var body: some View {
        Text(visibleText)
            .font(.custom("Consolas", size: 100))
            .fontWeight(.bold)
            .foregroundColor(Color.black.opacity(0.5))
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .scaledToFit()
            .frame(width: 400, height: 550, alignment: .center)
            .onAppear {
                startTyping()
            }
            .onDisappear {
                timer?.invalidate()
            }
    }
    
    private func startTyping() {
        timer?.invalidate() // Asegurarse de que el temporizador anterior esté detenido
        visibleText = "" // Reiniciar el texto visible
        counter = 0 // Reiniciar el contador
        isPaused = false // Reiniciar el estado de pausa
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { _ in
            if counter < text.count && !isPaused {
                let index = text.index(text.startIndex, offsetBy: counter)
                visibleText.append(text[index])
                counter += 1
            } else if counter >= text.count && !isPaused {
                isPaused = true
                DispatchQueue.main.asyncAfter(deadline: .now() + pauseDuration) {
                    startTyping() // Reiniciar el ciclo después de la pausa
                }
            }
        }
    }
}



struct LevelSelectView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectView()
    }
}
