import SwiftUI

struct Level1View: View {
    @State private var userInput = ""
    @State private var output = "Welcome to Console Master!\n\nLevel 1: The 'ls' Command\nYour task: Use the 'ls' command to list the contents of the current directory.\nIf you need help use the 'man' command: man ls\n"
    @State private var commandPrompt = "console@console-Master-Virtual-Platform:~$ "
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
               
                // Encabezado de la consola
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
                .frame(width: 1015, height: 60)
                .background(Color(red: 0.75, green: 0.31, blue: 0.3))

                // Contenido de la consola con auto-scroll
                ScrollViewReader { scrollView in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(output)
                                .foregroundColor(.white)
                                .font(.system(size: 30, design: .monospaced))

                            HStack {
                                Text(commandPrompt)
                                    .foregroundColor(.green)
                                    .font(.system(size: 25, design: .monospaced))
                                    .lineLimit(1)

                                TextField("", text: $userInput)
                                    .foregroundColor(.green)
                                    .font(.system(size: 25, design: .monospaced))
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .focused($isInputFocused)
                                    .submitLabel(.go)
                                    .onSubmit {
                                        executeCommand()
                                    }
                                    .frame(width: 300, height: 25)
                                    .disabled(levelCompleted) // Deshabilita el TextField una vez completado el nivel
                            }
                            // Este Spacer actúa como el elemento de scroll objetivo
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
                    NavigationLink(destination: Level2View()) {
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
        let trimmedCommand = userInput.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if trimmedCommand == "ls" {
            output += "\nconsole@console-Master-Virtual-Platform:~$ \(userInput)\nDocuments\nDownloads\nMusic"
            commandPrompt = "> Congratulations! You've completed Level 1.\nconsole@console-Master-Virtual-Platform:~$ "
            levelCompleted = true
        } else if trimmedCommand == "man ls" {
            output += "\nconsole@console-Master-Virtual-Platform:~$ \(userInput)\n\nNAME\n\tls - list directory contents\n\nDESCRIPTION\n\tList information about the FILEs (the current directory by default).\n\nSYNOPSIS\n\tls [OPTION]... [FILE]...\n\nEXAMPLES\n\tls -l\n\t\tList in long format.\n\tls -a\n\t\tList all entries including those starting with a dot.\n\nFor complete documentation, please refer to the manual page for ls."
        } else {
            output += "\nconsole@console-Master-Virtual-Platform:~$ \(userInput)\nThat's not the correct command. Try again."
        }

        userInput = "" // Reinicia la entrada del usuario después de ejecutar el comando
        scrollTarget = UUID() // Actualiza el identificador para desencadenar el auto-scroll
    }
    private func backToLevelSelect() {
            // Código para regresar al menú de selección de nivel
            self.dismiss()
        }
}

struct Level1View_Previews: PreviewProvider {
    static var previews: some View {
        Level1View()
    }
}

