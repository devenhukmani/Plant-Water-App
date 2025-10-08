//
//  ContentView.swift
//  Plant Water App
//
//  Created by Deven H on 10/3/25.
//

import SwiftUI

struct Watering: View {
    
    @State var fromServerSensor: String = ""
    @State var autoWater: Bool = false
    @State var on: Bool = false
    @State var onString: String = "Toggle On"
    
    var body: some View {
        VStack {
            List{
                Text("Current value: " + fromServerSensor)
                Button("Refresh"){
                    fromServerSensor = handleGetRequest(url: "http://192.168.5.128:3000/toApp")
                }
                Button(onString){
                    on = !on
                    if(!on){
                        onString = "Toggle On"
                    }else{
                        onString = "Togle Off"
                        autoWater = false
                    }
                }
                Toggle(isOn: $autoWater) {
                    Text("Automatic Watering")
                }.disabled(on)
            }.padding()
        }
        .padding()
        .onAppear(){
            fromServerSensor = handleGetRequest(url: "http://192.168.5.128:3000/toApp")
        }
        .onChange(of: autoWater){
            if(autoWater){
                //edit Data.json
                print("Active")
            }else{
                print("Unactive")
            }
        }
    }
}

#Preview {
    Watering()
}
