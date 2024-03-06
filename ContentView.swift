import SwiftUI

struct ContentView: View {
    @State private var isCursorVisible = true
    @State private var showAboutView = false
    @State private var showingLevelSelect = false
    @State private var isShowingLevel10 = false


    var body: some View {
        if isShowingLevel10 {
                    Level10View(isShowingLevel10: $isShowingLevel10)
        } else {
            
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.16, green: 0.17, blue: 0.21), Color(red: 0.09, green: 0.10, blue: 0.13)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                // Contenedor principal para la ventana de la terminal
                VStack {
                    Text("Console Master")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2) // Sombra para dar un efecto de relieve
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    
                    VStack(spacing: 0) {
                        
                        HStack {
                            Text("Console")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            // Botones de control de la ventana
                            HStack(spacing: 10) {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 15, height: 15)
                                Circle()
                                    .fill(Color.orange)
                                    .frame(width: 15, height: 15)
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 15, height: 15)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 15)
                        .frame(width: 1088, height: 60)
                        .background(Color(red: 0.75, green: 0.31, blue: 0.3))
                        
                        // Contenido de la terminal
                        VStack(alignment: .leading, spacing: 3) {
                            Text("console@console-Master-Virtual-Platform:~$ lsb_release -a")
                                .foregroundColor(Color.white)
                            Text("No LSB modules are available.")
                                .foregroundColor(Color.white)
                            Text("Distributor ID:\tEduardoTech")
                                .foregroundColor(Color.white)
                            Text("Description:\tOrozcoOS 3.3.2 LTS")
                                .foregroundColor(Color.white)
                            Text("Release:\t3.3.2")
                                .foregroundColor(Color.white)
                            Text("Codename:\tBurble")
                                .foregroundColor(Color.white)
                            // Última línea con cursor parpadeante
                            HStack {
                                Text("console@console-Master-Virtual-Platform:~$")
                                    .foregroundColor(Color.green)
                                Rectangle()
                                    .fill(Color.green)
                                    .opacity(isCursorVisible ? 1 : 0)
                                    .frame(width: 8, height: 27)
                                    .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: true), value: isCursorVisible)
                                    .onAppear {
                                        self.isCursorVisible.toggle()
                                    }
                            }
                        }
                        .font(.system(size: 30, design: .monospaced)) // Tamaño de la letra
                        .padding(.all, 15)
                        .background(Color.black)
                    }
                    .cornerRadius(4)
                    .shadow(radius: 5)
                    .padding(.horizontal, 35)
                    
                    Spacer()
                    
                    Button(action: {
                        // Activa la presentación de LevelSelectView como una cubierta de pantalla completa
                        self.showingLevelSelect = true
                    }) {
                        Text("Start")
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .background(Color.green)
                            .cornerRadius(15)
                    }
                    .shadow(radius: 5)
                    .padding(.bottom, 20)
                    .fullScreenCover(isPresented: $showingLevelSelect) {
                        LevelSelectView()
                    }
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            showAboutView = true
                        }) {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("About")
                            }
                            .foregroundColor(.white)
                            .font(.title2)
                        }
                        .sheet(isPresented: $showAboutView) {
                            AboutView()
                        }
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


