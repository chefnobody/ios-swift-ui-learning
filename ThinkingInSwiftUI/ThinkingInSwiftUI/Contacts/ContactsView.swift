//
//  ContactsView.swift
//  ThinkingInSwiftUI
//
//  Created by Aaron Connolly on 1/8/21.
//

import SwiftUI

struct ContactDetailView: View {
    @ObservedObject var contact: Contact
    
    var body: some View {
        VStack {
            Text(contact.name).bold()
            Text(contact.city)
        }
    }
}

struct ContactsView: View {
    @State var contacts: [Contact]
    @State var selection: Contact?
    
    var body: some View {
        VStack {
            HStack {
                ForEach(contacts) { contact in
                    Button(contact.name) { self.selection = contact }
                }
            }
            if let c = selection {
                ContactDetailView(contact: c)
            }
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView(contacts: [
            Contact(name: "Aaron", city: "San Diego, CA"),
            Contact(name: "Marc", city: "Reston, VA")
        ])
    }
}
