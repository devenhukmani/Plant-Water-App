//
//  ViewHandler.swift
//  Plant Water App
//
//  Created by Deven H on 10/1/25.
//

import SwiftUI
import UIKit

struct ViewHandler<Page : View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int
    @Binding var direction: UIPageViewController.NavigationDirection

    func makeUIViewController(context: Context) -> UIPageViewController {
            let viewHandler = UIPageViewController(
                transitionStyle: .scroll,
                navigationOrientation: .horizontal)

            return viewHandler
        }
    
    func updateUIViewController(_ ViewHandler: UIPageViewController, context: Context) {
            ViewHandler.setViewControllers(
                [UIHostingController(rootView: pages[currentPage])], direction: direction, animated: true)
        }
    
}
