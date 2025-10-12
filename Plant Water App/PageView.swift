//
//  PageView.swift
//  Plant Water App
//
//  Created by Deven H on 10/1/25.
//

import SwiftUI


struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    @State private var direction = UIPageViewController.NavigationDirection.forward

    var body: some View {
        ViewHandler(pages: pages, currentPage: $currentPage, direction: $direction)
        if(currentPage == 0){ //this if statement gives info for "navigation buttons" for each page
            Button("Water Plants"){
                direction = checkDirection(currentPage: 0)
                currentPage = 2
            }
                .disabled(!connected)
            Button("Connect to a New Device"){
                direction = checkDirection(currentPage: 0);
                currentPage = 1;
            }
        }else if(currentPage != 0){
            if(currentPage == 3){
                Button("Back"){
                    direction = UIPageViewController.NavigationDirection.reverse
                    currentPage = 2;
                }
            }
            Button("Home"){
                direction = checkDirection(currentPage: currentPage);
                currentPage = 0;
            }
            if(currentPage == 2){
                Button("Add Plant"){
                    direction = UIPageViewController.NavigationDirection.forward
                    currentPage = 3;
                }
            }
        }
        Button("Test"){
            let dataStruct = jsonFileToStruct(filename: "Data")
            print(dataStruct.device)
        }
    }
}

func checkDirection(currentPage: Int) -> UIPageViewController.NavigationDirection {
    if(currentPage == 0){
        return UIPageViewController.NavigationDirection.forward
    }else{
        return UIPageViewController.NavigationDirection.reverse
    }
}

let allPages: [AnyView] = [AnyView(Home()), AnyView(SendWiFiInfo()), AnyView(Watering()), AnyView(Plant())]

#Preview {
    PageView(pages: allPages)
}
