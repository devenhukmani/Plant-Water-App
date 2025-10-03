//
//  PlantView.swift
//  Plant Water App
//
//  Created by Deven H on 10/8/25.
//

import SwiftUI

struct Plant: View {
    
    @State var plantName: String = ""
    @State private var level = 50.0
    @State private var isEditing = false
    
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
                        Text("Water level: \(level)")
                            .foregroundColor(isEditing ? .red : .blue)
                    }
            }
            .padding()
            Button("Save"){
                
            }
        }
        .padding()
    }
}

#Preview {
    Plant()
}
