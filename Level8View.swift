import SwiftUI

struct Level8View: View {
    @State private var userInput = ""
    @State private var output = "Welcome to Console Master!\n\nLevel 8: The 'mkdir' Command\nYour task: Create a new directory named 'NewFolder'.\nIf you need help use the 'man' command: man mkdir\n"
    @State private var commandPrompt = "console@console-Master-Virtual-Platform:~/Documents$ "
    @State private var levelCompleted = false
    @FocusState private var isInputFocused: Bool
    @State private var scrollTarget: UUID? = UUID() // Identificador inicial para el auto-scroll
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.16, green: 0.17, blue: 0.21), Color(red: 0.09, green: 0.10, blue: 0.13)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // Encabezado de la consola, ScrollView y Botón para el siguiente nivel, como se ha implementado en los niveles anteriores
             
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
                                .font(.system(size: 23, design: .monospaced))

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
                    NavigationLink(destination: Level9View()) {
                        Text("Next Level")
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
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
        if trimmedInput == "mkdir newfolder" {
            output += "\nconsole@console-Master-Virtual-Platform:\(commandPrompt)$ \(userInput)\n> 'NewFolder' directory created successfully."
            commandPrompt = "> Congratulations! You've completed Level 8.\nconsole@console-Master-Virtual-Platform:\(commandPrompt)$ "
            levelCompleted = true
        } else if trimmedInput.starts(with: "man ") {
            let command = trimmedInput.replacingOccurrences(of: "man ", with: "")
            switch command {
            case "mkdir":
                output += "\nconsole@console-Master-Virtual-Platform:\(commandPrompt)$ man \(command)\n\nNAME\n\tmkdir - make directories\n\nDESCRIPTION\n\tThe mkdir \tcommand is used to create directories on a file \tsystem. By default, the mode of created \tdirectories is 0777 minus the bits set in the umask.\n\nUSAGE\n\tmkdir DIRECTORY\n\tTo create a \tnew directory, use 'mkdir directory_name'. For \texample, 'mkdir NewFolder' creates a new \tdirectory named NewFolder.\n"
            default:
                output += "\nconsole@console-Master-Virtual-Platform:\(commandPrompt)$ man \(command)\nNo manual entry for \(command)"
            }
        } else {
            output += "\nconsole@console-Master-Virtual-Platform:\(commandPrompt)$ \(userInput)\nThat's not the correct command. Try 'mkdir NewFolder'."
        }
        userInput = "" // Reinicia la entrada del usuario después de ejecutar el comando
        scrollTarget = UUID() // Actualiza el identificador para desencadenar el auto-scroll
    }

    private func backToLevelSelect() {
            // Código para regresar al menú de selección de nivel
            self.dismiss()
        }
}

struct Level8View_Previews: PreviewProvider {
    static var previews: some View {
        Level8View()
    }
}

