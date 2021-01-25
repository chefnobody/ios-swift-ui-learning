//
//  DataLoader.swift
//  ThinkingInSwiftUI
//
//  Created by Aaron Connolly on 1/8/21.
//

import Combine
import SwiftUI

final class ImageLoader: ObservableObject {
    var requestCancellable: AnyCancellable?
    
    @Published var loading: Bool = false
    @Published var image: UIImage? = nil
    
    func load(_ url: URL) {
        loading = true
        
        requestCancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .map { UIImage.init(data: $0)! }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                self.loading = false
                if case let .failure(error) = result {
                    print("Oops: \(error)")
                }
            }, receiveValue: { image in
                self.loading = false
                print("Image loaded: \(image)")
                self.image = image
            })
    }
}

final class DataLoader<T: Decodable>: ObservableObject {
    let url: URL
    var requestCancellable: AnyCancellable?
    
    @Published var loading: Bool = false
    @Published var data: [T] = []
    
    init(url: URL) {
        self.url = url
        self.data = []
    }
    
    func load() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        loading = true
        
        requestCancellable = URLSession.shared
            .dataTaskPublisher(for: self.url)
            .map(\.data)
            .decode(type: [T].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.loading = false
            }, receiveValue: {
                self.data = $0
                self.loading = false
            })
    }
}
