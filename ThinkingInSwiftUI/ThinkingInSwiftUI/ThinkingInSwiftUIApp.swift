//
//  ThinkingInSwiftUIApp.swift
//  ThinkingInSwiftUI
//
//  Created by Aaron Connolly on 1/5/21.
//

import SwiftUI
import SignIn

@main
struct ThinkingInSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
//            KnobView(volume: 0.5)
//            EnvironmentTestView()
//            PhotosView()
            SignInView(viewModel: .init(authClient: .mock))
        }
    }
}
