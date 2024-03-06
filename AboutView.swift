import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.green.opacity(0.85)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Text("About this App")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("I developed this App with a clear vision in mind: to empower my fellow software engineering students at Campus IV of the Facultad de Negocios, Universidad Autonoma de Chiapas. This app serves as a bridge, making the foundational Unix-based commands accessible and comprehensible, especially for those of us who utilize operating systems like macOS and GNU/Linux in our academic and personal projects.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)


                    Text("Creating Console Master was more than just a project; it was a journey into the intricacies of SwiftUI and a deep dive into the essence of user-centric design. Inspired by the vibrant culture of innovation at our university and driven by a passion to contribute to the software engineering community, this app embodies a fusion of technology and education. It's a testament to what we can achieve when we aim to make learning both accessible and engaging for everyone.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)


                    Text("OrozcoOS is a fictional operating system created to demonstrate the power of SwiftUI. Developed by EduardoTech, it seeks to innovate in the world of operating systems with version 3.3.2 under the codename Burble.")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()

                    Divider()

                    Group {
                        Text("This app was developed by Jose Eduardo Orozco Cardenas")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        Text("I'm a 22 years old Mexican guy, studying since 2020 a degree in software engineering, at the Universidad Autonoma de Chiapas")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                    }
                    .font(.system(size: 18))
                    .padding()

                    HStack(spacing: 20) {
                        VStack {
                            Text("iOS Development Lab in México Community")
                                .foregroundColor(.white)
                            
                            Image("swift-logo") // Asegúrate de que esta imagen esté en tus assets
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }

                        VStack {
                            Text("UNIVERSIDAD AUTONOMA DE CHIAPAS")
                                .foregroundColor(.white)

                            Image("unach-logo") // Asegúrate de que esta imagen esté en tus assets
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                    }
                    .font(.system(size: 16))
                    .padding()
                }
                .padding()
            }
        }
        .navigationTitle("About OrozcoOS")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Close") {
                    dismiss()
                }
                .foregroundColor(.white)
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

