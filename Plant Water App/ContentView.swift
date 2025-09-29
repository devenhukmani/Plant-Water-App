//
//  ContentView.swift
//  Plant Water App
//
//  Created by Deven H on 8/28/25.
//

let bodySample: [String: String] = ["user_id": "12"]

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Send/Receive Data") {
                let result: String = makeGetRequest(urlString: "http://192.168.5.128:3000/toApp")
                print(result)
                makePostRequest(url: "http://192.168.5.128:3000/fromApp", toSend: ["id": 13, "name": "jack"])
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
