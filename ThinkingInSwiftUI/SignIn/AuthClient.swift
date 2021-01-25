//
//  AuthClient.swift
//  SignIn
//
//  Created by Aaron Connolly on 1/11/21.
//

import Combine

public struct AuthClient {
    var authenticateUser: (String, String) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
    var resetPassword: (String) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

public extension AuthClient {
    static let mock: AuthClient = {
        let userPassStore = [
            "captain-jack": "sparrow"
        ]
        
        return AuthClient { username, password in
            if let userKey = userPassStore[username], userKey == password {
                return Just((Data("true".utf8), URLResponse()))
                    .delay(for: 2, scheduler: DispatchQueue.main)
                    .setFailureType(to: URLError.self)
                    .eraseToAnyPublisher()
            }
            
            return Just((Data("false".utf8), URLResponse()))
                .delay(for: 2, scheduler: DispatchQueue.main)
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
            
        } resetPassword: { email in
            return Just((Data(), URLResponse()))
                .delay(for: 2, scheduler: DispatchQueue.main)
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }
    }()
}
