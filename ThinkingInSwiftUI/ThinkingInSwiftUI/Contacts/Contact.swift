//
//  Contact.swift
//  ThinkingInSwiftUI
//
//  Created by Aaron Connolly on 1/8/21.
//

import Combine
import SwiftUI

final class Contact: ObservableObject, Identifiable {
    let id = UUID()
    
    @Published var name: String
    @Published var city: String
    
    init(name: String, city: String) {
        self.name = name
        self.city = city
    }
}

