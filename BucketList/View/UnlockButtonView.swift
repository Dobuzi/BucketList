//
//  UnlockButtonView.swift
//  BucketList
//
//  Created by 김종원 on 2020/11/07.
//

import SwiftUI
import LocalAuthentication

struct UnlockButtonView: View {
    @Binding var isUnlocked: Bool
    @State var isError = false
    @State var errorMessage = ""
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button("Unlock Places") {
                        self.authenticate()
                    }
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .shadow(radius: 10)
                    Spacer()
                }
                Spacer()
            }
        }
        .alert(isPresented: $isError, content: {
            Alert(title: Text("Auth Error"), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
        })
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        self.isError = false
                        self.isUnlocked = true
                    } else {
                        self.isError = true
                        self.errorMessage = authError?.localizedDescription ?? "Unknown Error"
                    }
                }
            }
        } else {
            self.isError = true
            self.errorMessage = error?.localizedDescription ?? "Unknown Error"
        }
    }
}

struct UnlockButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockButtonView(isUnlocked: .constant(false))
    }
}
