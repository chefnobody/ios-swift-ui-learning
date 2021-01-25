//
//  FancyTextField.swift
//  SignIn
//
//  Created by Aaron Connolly on 1/11/21.
//

import SwiftUI

public struct FancyTextField: View {
    private var textValue: Binding<String>
    
    var placeholder: String
    var borderColor: Color
    var focusedBorderColor: Color
    
    @State private var isEditing: Bool = false
    
    public init(
        textValue: Binding<String>,
        placeholder: String = "Text",
        borderColor: Color = .black,
        focusedBorderColor: Color = .red) {
        self.textValue = textValue
        self.placeholder = placeholder
        self.borderColor = borderColor
        self.focusedBorderColor = focusedBorderColor
    }
    
    public var body: some View {
        TextField(
            placeholder,
            text: textValue)
        { self.isEditing = $0 }
        onCommit: {
            // TBD perform validation?
        }
        .autocapitalization(.none)
        .padding(
            EdgeInsets.init(
                top: 15,
                leading: 10,
                bottom: 15,
                trailing: 10
            )
        )
        .cornerRadius(5.0)
        .border(isEditing ? focusedBorderColor : borderColor)
        
    }
}
