//
//  CoreDataTestApp.swift
//  CoreDataTest
//
//  Created by Izadora Matias on 27/08/25.
//

import SwiftUI

@main
struct CoreDataTestApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
