//
//  ContentView.swift
//  Plant Water App
//
//  Created by Deven H on 8/28/25.
//

let bodySample: [String: String] = ["user_id": "12"]

import SwiftUI

struct ContentView: View {
    @State private var textInputOne: String = ""
    @State private var textInputTwo: String = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            List {
                TextField("Item 1", text: $textInputOne)
                TextField("Item 2", text: $textInputTwo)
            }
            Button("Send/Receive Data") {
                let result: String = makeGetRequest(urlString: "http://192.168.5.128:3000/toApp")
                print(result)
                makePostRequest(url: "http://192.168.5.128:3000/fromApp", toSend: ["Item 1": textInputOne, "Item 2": textInputTwo])
            }
        }
        .padding()
        .onAppear(){
            
        }
    }
}

#Preview {
    ContentView()
}
