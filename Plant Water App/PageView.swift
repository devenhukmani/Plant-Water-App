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
        Button("Test"){
            if(currentPage == 0){
                direction = checkDirection(currentPage: 0)
                currentPage = 1;
            }else{
                direction = checkDirection(currentPage: 1)
                currentPage = 0;
            }
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

let allPages: [AnyView] = [AnyView(ContentView()), AnyView(ContentView2())]

#Preview {
    PageView(pages: allPages)
}
