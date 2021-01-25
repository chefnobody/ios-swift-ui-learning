//
//  SignInView.swift
//  SignIn
//
//  Created by Aaron Connolly on 1/7/21.
//

import Combine
import SwiftUI

public struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    @State private var showingAlert = false
    
    public init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            Text("Sign in")
                .font(.headline)
            Form {
                TextField("Username", text: $viewModel.username)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .autocapitalization(.none)
                    
                Button(
                    action: {
                        viewModel.signIn()
                    },
                    label: {
                        Text("Sign In")
                    }
                )
                    .frame(maxWidth: .infinity)
                    .padding(.all, 5.0)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                
                if viewModel.isAuthenticated {
                    Text("Sign in succeeded")
                }
                
                Button(
                    action: {
                        viewModel.resetPassword()
                    },
                    label: {
                        Text("Reset password?")
                            .font(.caption)
                            .underline()
                    }
                )
            }
            .padding(5.0)
        }
        /*.alert(isPresented: $showingAlert) {
            Alert(
                title: "Something went wrong",
                message: $viewModel.errorMessage,
                dismissButton: Button("OK", action: { print("OK") })
            )
        }*/
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel(authClient: .mock))
    }
}
