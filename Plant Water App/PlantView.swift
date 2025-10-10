//
//  PlantView.swift
//  Plant Water App
//
//  Created by Deven H on 10/8/25.
//

import SwiftUI

struct Plant: View {
    
    @State var plantName: String = ""
    @State var level = 50.0
    @State var isEditing = false
    @State var levelLabel: String = "Low"
    
    var body: some View {
        VStack {
            List{
                TextField("Enter plant name...", text: $plantName)
                VStack {
                    Slider(
                        value: $level,
                        in: 0...700,
                        onEditingChanged: { editing in
                            isEditing = editing
                        }
                    )
                    Text("Water level: \(levelLabel)")
                        .foregroundColor(isEditing ? .red : .blue)
                }
            }
            .onChange(of: level){
                if(level > 500){
                    levelLabel = "High"
                }else if(level > 300){
                    levelLabel = "Medium"
                }else{
                    levelLabel = "Low"
                }
            }
            .padding()
            Button("Save"){
                //Send to data file, send to device
            }
        }
        .padding()
    }
}

#Preview {
    Plant()
}
