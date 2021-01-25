//
//  EnvironmentTestView.swift
//  ThinkingInSwiftUI
//
//  Created by Aaron Connolly on 1/22/21.
//

import SwiftUI

struct EnvironmentTestView: View {
    var body: some View {
        VStack {
            Text("Text 1")
            HStack {
                Text("Text 2")
                Text("Text 3")
            }.font(.largeTitle)
        }
        .debug()
    }
}

