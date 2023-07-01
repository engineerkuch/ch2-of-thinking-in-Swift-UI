//
//  AddressBook.swift
//  ch2
//
//  Created by Kelvin KUCH on 12.06.2023.
//

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

struct Details: View {
    @ObservedObject var contact: Contact
    
    var body: some View {
        VStack {
            Text(contact.name).bold()
            Text(contact.city)
        }
    }
}

struct AddressBook: View {
    @State var selection: Contact?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddressBook_Previews: PreviewProvider {
    static var previews: some View {
        AddressBook()
    }
}
