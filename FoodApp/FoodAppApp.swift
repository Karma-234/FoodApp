//
//  FoodAppApp.swift
//  FoodApp
//
//  Created by MAC  on 10/15/23.
//

import SwiftUI

@main
struct FoodAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
