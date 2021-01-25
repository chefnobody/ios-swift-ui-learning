//
//  Photo.swift
//  ThinkingInSwiftUI
//
//  Created by Aaron Connolly on 1/8/21.
//

import Foundation

struct Photo: Decodable, Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: URL
    let downloadUrl: URL
}
