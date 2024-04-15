//
//  iTourApp.swift
//  iTour
//
//  Created by Yunus Emre Berdibek on 13.01.2024.
//

import SwiftData
import SwiftUI

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
