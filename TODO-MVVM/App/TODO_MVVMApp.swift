//
//  TODO_MVVMApp.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import SwiftUI

@main
struct TODO_MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewFactory.makeView()
        }
    }
}
