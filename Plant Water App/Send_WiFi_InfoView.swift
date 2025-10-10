//
//  Send_WiFi_InfoView.swift
//  Plant Water App
//
//  Created by Deven H on 10/1/25.
//

import SwiftUI

struct SendWiFiInfo: View {
    @State private var textInputOne: String = ""
    @State private var textInputTwo: String = ""
    var body: some View {
        VStack {
            List {
                Text("Enter your WiFi credentials here")
                TextField("Name", text: $textInputOne)
                TextField("Password", text: $textInputTwo)
            }
            Button("Send info to connected device") {
                makePostRequest(url: "http://192.168.4.1:3000/gettingWifiInfo", toSend: ["SSID": textInputOne, "Password": textInputTwo])
            }
        }
        .padding()
        .onAppear(){
            
        }
    }
}

#Preview {
    SendWiFiInfo()
}
