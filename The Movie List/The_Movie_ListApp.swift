//
//  The_Movie_ListApp.swift
//  The Movie List
//
//  Created by Mayank Patel on 26/10/24.
//

import SwiftUI

@main
struct The_Movie_ListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
