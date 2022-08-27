//
//  ClipsterApp.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/27/22.
//

import SwiftUI

@main
struct ClipsterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ClipboardView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
