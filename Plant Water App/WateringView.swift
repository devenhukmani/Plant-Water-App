//
//  ContentView.swift
//  Plant Water App
//
//  Created by Deven H on 10/3/25.
//

import SwiftUI

struct Watering: View {
    
    @State var fromServerSensor: String = ""
    
    var body: some View {
        VStack {
            Text("Current value: " + fromServerSensor)
            Button("Refresh"){
                fromServerSensor = handleGetRequest(url: "http://192.168.5.128:3000/toApp")
            }
        }
        .padding()
        .onAppear(){
            fromServerSensor = handleGetRequest(url: "http://192.168.5.128:3000/toApp")
        }
    }
}

#Preview {
    Watering()
}
