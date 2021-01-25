//
//  View+Extensions.swift
//  ThinkingInSwiftUI
//
//  Created by Aaron Connolly on 1/22/21.
//

import SwiftUI

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
