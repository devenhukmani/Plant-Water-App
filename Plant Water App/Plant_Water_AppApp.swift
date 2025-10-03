//
//  Plant_Water_AppApp.swift
//  Plant Water App
//
//  Created by Deven H on 8/28/25.
//

import SwiftUI

var connected = true //temp

@main
struct Plant_Water_AppApp: App {
    var body: some Scene {
        WindowGroup {
            let allPages: [AnyView] = [AnyView(Home()), AnyView(SendWiFiInfo()), AnyView(Watering()), AnyView(Plant())]

            PageView(pages: allPages)
        }
    }
}
