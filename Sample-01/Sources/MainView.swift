import SwiftUI
import Auth0
import DeviceCheck

struct MainView: View {
    @State var user: User?

    var body: some View {
        if let user = self.user {
            VStack {
                ProfileView(user: user)
                Button("Logout", action: self.logout)
            }
        } else {
            VStack {
                HeroView()
                Button("Login", action: self.login)
            }
        }
    }
}

extension MainView {
    func login() {
<<<<<<< HEAD
        Auth0
            .webAuth()
            .useHTTPS() // Use a Universal Link callback URL on iOS 17.4+ / macOS 14.4+
            .start { result in
                switch result {
                case .success(let credentials):
                    self.user = User(from: credentials.idToken)
                case .failure(let error):
                    print("Failed with: \(error)")
                }
=======
        Task {
            guard let dcToken = await deviceCheckToken()?.base64EncodedString() else {
                return print("Failed to get Device Token!")
>>>>>>> origin/device-token
            }
            
            print(dcToken)

            do {
                let credentials = try await Auth0.webAuth().parameters(["dc_token": dcToken]).start()
                self.user = User(from: credentials.idToken)
            } catch {
                print("Failed with: \(error)")
            }
        }
    }

    func logout() {
        Auth0
            .webAuth()
            .useHTTPS() // Use a Universal Link logout URL on iOS 17.4+ / macOS 14.4+
            .clearSession { result in
                switch result {
                case .success:
                    self.user = nil
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }

    func deviceCheckToken() async -> Data? {
        guard DCDevice.current.isSupported else { return nil }
        return try? await DCDevice.current.generateToken()
    }

}
