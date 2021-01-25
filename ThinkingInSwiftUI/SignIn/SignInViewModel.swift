//
//  SignInViewModel.swift
//  SignIn
//
//  Created by Aaron Connolly on 1/11/21.
//

import Combine

public final class SignInViewModel: ObservableObject {
    struct ApiError: Identifiable {
        let id = UUID()
        let message: String
    }
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var isAuthenticated: Bool = false
    @Published var error: ApiError? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    private let authClient: AuthClient
    
    public init(authClient: AuthClient) {
        self.authClient = authClient
    }
    
    func signIn() {
        authClient
            .authenticateUser(username, password)
            .map { data, _ in Bool(String(decoding: data, as: UTF8.self)) ?? false }
            .replaceError(with: false)
            .sink { result in
                self.isAuthenticated = result
                self.error = result ? nil : ApiError(message: "Sign in failed.")
            }
            .store(in: &cancellables)
    }
    
    func resetPassword() {
//        authClient
//            .resetPassword(username)
//            .store(in: &cancellables)
    }
}
