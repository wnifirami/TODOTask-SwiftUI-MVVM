//
//  EntryField.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import SwiftUI

struct EntryField: View {
    let iconName: String
    let placeholder: String
    let prompt: String
    @State var isSecure: Bool = false
    var isPasswordField: Bool = false
    @Binding var field: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: iconName)
                    .font(.headline)
                    .foregroundColor(.secondary)
                if isSecure {
                    SecureField(placeholder, text: $field)
                } else {
                    TextField(placeholder, text: $field)
                }
                if isPasswordField {
                    Button {
                        isSecure.toggle()
                    } label: {
                        Image(systemName: isSecure ?  "eye.fill" : "eye.slash.fill")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }

                }
            }.autocapitalization(.none)
                .padding(8)
                .background(Color(.secondarySystemBackground))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary, lineWidth: 1))
            
            Text(prompt)
                .font(.caption)
                .fontWeight(.light)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.secondary)
        }
    }
}

struct EntryField_Previews: PreviewProvider {
    static var previews: some View {
        EntryField(iconName: "envelope", placeholder: "Email adress", prompt: "Please enter a valid email adress", field: .constant(""))
    }
}
