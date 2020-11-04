//
//  ContentView.swift
//  BucketList
//
//  Created by 김종원 on 2020/11/04.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName < rhs.firstName
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Jungmi", lastName: "Lee"),
        User(firstName: "Doa", lastName: "Kim"),
        User(firstName: "Jongwon", lastName: "Kim")
    ].sorted()
    
    var body: some View {
        Text("Hello")
            .onTapGesture(count: 1, perform: {
                let str = "Test Message"
                let url = self.getDocumentsDirectory().appendingPathComponent("message.txt")
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            })
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
