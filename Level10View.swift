import SwiftUI

struct Level10View: View {
    @State private var userInput = ""
    @State private var output = "Welcome to Console Master!\n\nLevel 10: The 'chmod' Command\nYour task: Change the permissions of the file 'example.txt' to be readable, writable, and executable by the owner only.\nIf you need help use the 'man' command: man chmod\n"
    @State private var commandPrompt = "console@console-Master-Virtual-Platform:~/Documents$ "
    @State private var levelCompleted = false
    @FocusState private var isInputFocused: Bool
    @State private var scrollTarget: UUID? = UUID() // Identificador inicial para el auto-scroll
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @Binding var isShowingLevel10: Bool


    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.16, green: 0.17, blue: 0.21), Color(red: 0.09, green: 0.10, blue: 0.13)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // Encabezado de la consola, ScrollView y Botón para el siguiente nivel, implementados como en los niveles anteriores
                HStack {
                    Text("Console")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()

                    // Botones de control de la ventana
                    HStack(spacing: 10) {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 25, height: 25)
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 25, height: 25)
                        Circle()
                            .fill(Color.green)
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical)
                .frame(width: 995, height: 60)
                .background(Color(red: 0.75, green: 0.31, blue: 0.3))
                
                
                ScrollViewReader { scrollView in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(output)
                                .foregroundColor(.white)
                                .font(.system(size: 22.5, design: .monospaced))

                            HStack {
                                Text(commandPrompt)
                                    .foregroundColor(.green)
                                    .font(.system(size: 23, design: .monospaced))
                                    .lineLimit(1)

                                TextField("", text: $userInput)
                                    .foregroundColor(.green)
                                    .font(.system(size: 23, design: .monospaced))
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .focused($isInputFocused)
                                    .submitLabel(.go)
                                    .onSubmit {
                                        executeCommand()
                                    }
                                    .frame(width: 200, height: 25)
                                    .disabled(levelCompleted)
                            }
                            Spacer().id(scrollTarget)
                        }
                        .padding()
                    }
                    .frame(maxHeight: 600)
                    .background(Color.black)
                    .cornerRadius(4)
                    .shadow(radius: 5)
                    .padding(.horizontal, 35)
                    .onChange(of: scrollTarget) { target in
                        withAnimation {
                            scrollView.scrollTo(target, anchor: .bottom)
                        }
                    }
                }

                Spacer()

                if levelCompleted {
                    Button("Congratulations! You've completed all levels.") {
                        backToLevelSelect()
                    }
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }

                Spacer()
            }
            .cornerRadius(4)
            .shadow(radius: 10)
            .padding(.horizontal, 40)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isInputFocused = true
            }
        }
    }

    func executeCommand() {
        let trimmedInput = userInput.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if trimmedInput == "chmod 700 example.txt" {
            output += "\nconsole@console-Master-Virtual-Platform:\(commandPrompt)$ \(userInput)\n> 'example.txt' now has owner-only permissions."
            commandPrompt = "> Nice! You've got the 'chmod' command down.\nconsole@console-Master-Virtual-Platform:\(commandPrompt)$ "
            levelCompleted = true
        } else if trimmedInput.starts(with: "man ") {
            let command = trimmedInput.replacingOccurrences(of: "man ", with: "")
            switch command {
            case "chmod":
                output += """
                \(commandPrompt)$ man \(command)
                
                \nNAME
                \tchmod - changes file permissions.
                
                \nDESCRIPTION
                \t'chmod' alters file or directory permissions using symbolic or numeric modes.
                
                \nBITS
                \tPermissions involve 3 bits:
                \t- Read (r) = 4
                \t- Write (w) = 2
                \t- Execute (x) = 1
                \tCombine bits for desired access (e.g., 7 for full access).
                
                \nUSAGE
                \tUse 'chmod [options] mode file' to set permissions.
                \tExample: 'chmod 755 file.txt' makes the file readable, writable,\n and executable by the owner, and readable and executable by others.
                """
            default:
                output += "\nconsole@console-Master-Virtual-Platform:\(commandPrompt)$ man \(command)\nNo manual entry for \(command)"
            }
        } else {
            output += "\nconsole@console-Master-Virtual-Platform:\(commandPrompt)$ \(userInput)\nTry 'chmod 700 example.txt'."
        }
        userInput = "" // Clear user input after command execution
        scrollTarget = UUID() // Update scroll target for auto-scroll
    }


    private func backToLevelSelect() {
            // Código para regresar al menú de selección de nivel
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = UIHostingController(rootView: ContentView())
                window.makeKeyAndVisible()
            }
        
        }
}

struct Level10View_Previews: PreviewProvider {
    static var previews: some View {
        Level10View(isShowingLevel10: .constant(true))
    }
}

