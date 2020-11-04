//
//  ContentView.swift
//  BucketList
//
//  Created by 김종원 on 2020/11/04.
//

import LocalAuthentication
import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName < rhs.firstName
    }
}

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Jungmi", lastName: "Lee"),
        User(firstName: "Doa", lastName: "Kim"),
        User(firstName: "Jongwon", lastName: "Kim")
    ].sorted()
    
    @State private var loadingState = LoadingState.loading
    @State private var isUnlocked = false
    
    var body: some View {
        ZStack {
            MapView()
                .ignoresSafeArea()
            Text(self.isUnlocked ? "Unlocked" : "Locked")
                .frame(width: 100, height: 100)
                .background(Color.white)
        }
        .onAppear(perform: authenticate)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        
                    }
                }
                
            }
        } else {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
