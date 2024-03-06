import SwiftUI

struct Level5View: View {
    @State private var userInput = ""
    @State private var output = "Welcome to Console Master!\n\nLevel 5: The 'cp' Command\nYour task: Use the 'cp' command to copy the file named 'Example.txt' to a new file named 'ExampleBackup.txt'.\nIf you need help use the 'man' command: man cp\n"
    @State private var commandPrompt = "console@console-Master-Virtual-Platform:~/Documents$ "
    @State private var levelCompleted = false
    @State private var currentDirectory = "~/Documents"
    @FocusState private var isInputFocused: Bool
    @State private var scrollTarget: UUID? = UUID() // Identificador inicial para el auto-scroll
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.16, green: 0.17, blue: 0.21), Color(red: 0.09, green: 0.10, blue: 0.13)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // Componentes de la UI reutilizados de los niveles anteriores
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
                .frame(width: 1013, height: 60)
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
                    NavigationLink(destination: Level6View()) {
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

        if trimmedInput == "cp example.txt examplebackup.txt" {
            output += "\nconsole@console-Master-Virtual-Platform:\(currentDirectory)$ \(userInput)\n> You've successfully copied 'Example.txt' to 'ExampleBackup.txt'."
            commandPrompt = "> Congratulations! You've completed Level 5.\nconsole@console-Master-Virtual-Platform:\(currentDirectory)$ "
            levelCompleted = true
        } else if trimmedInput.starts(with: "man ") {
            let command = trimmedInput.replacingOccurrences(of: "man ", with: "")
            switch command {
            case "cp":
                output += "\nconsole@console-Master-Virtual-Platform:\(currentDirectory)$ man \(command)\n\nNAME\n\tcp - copy files and directories.\n\nDESCRIPTION\n\tThe cp command \tcopies files and directories. By default, it \tcopies files and directories into a \tdestination directory. Use the cp command to \tcopy files from one location to another.\n\nUSAGE\n\tcp SOURCE DESTINATION\n\tTo copy a file or directory, use 'cp source destination'. For example, 'cp original.txt backup.txt' copies 'original.txt' to 'backup.txt'.\n"
            default:
                output += "\nconsole@console-Master-Virtual-Platform:\(currentDirectory)$ man \(command)\nNo manual entry for \(command)"
            }
        } else {
            output += "\nconsole@console-Master-Virtual-Platform:\(currentDirectory)$ \(userInput)\nThat's not the correct command. Try 'cp Example.txt ExampleBackup.txt'."
        }

        userInput = "" // Reinicia la entrada del usuario después de ejecutar el comando
        scrollTarget = UUID() // Actualiza el identificador para desencadenar el auto-scroll
    }

    private func backToLevelSelect() {
            // Código para regresar al menú de selección de nivel
            self.dismiss()
        }
}

struct Level5View_Previews: PreviewProvider {
    static var previews: some View {
        Level5View()
    }
}

