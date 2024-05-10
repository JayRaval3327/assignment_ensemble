//
//  assignment_ensembleApp.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-08.
//

import SwiftUI

@main
struct assignment_ensembleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MovieView(viewModel: SearchMovieViewModel(adapter: NetworkAdapter()))
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Server.selected = .omdb
        return true
    }
}
