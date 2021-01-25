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
        .alert(item: $viewModel.error) { error -> Alert in
            Alert(
                title: Text("Something went wrong"),
                message: Text(error.message),
                dismissButton: .default(Text("OK"))
                )
        }
//        .alert(item: $viewModel.errorMessage, content: { message -> Alert
//            Alert(title: Text("Something went wrong"),
//                  message: Text(message),
//                  dismissButton: .default(Text("OK"))
//            )
//        })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel(authClient: .mock))
    }
}
