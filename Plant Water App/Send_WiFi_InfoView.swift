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
                var editStruct = jsonFileToStruct(filename: "Data")
                editStruct.ssid = textInputOne
                editStruct.password = textInputTwo
                writeDataToJson(data: editStruct, filename: "Data")
                makePostRequest(url: "http://192.168.4.1:3000/gettingWiFiInfo", toSend: structToDictionary(data: editStruct))
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
