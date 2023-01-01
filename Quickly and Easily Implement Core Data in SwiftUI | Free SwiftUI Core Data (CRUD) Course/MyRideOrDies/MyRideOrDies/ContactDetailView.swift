//
//  ContactDetailView.swift
//  MyRideOrDies
//
//  Created by Tunde Adegoroye on 10/12/2022.
//

import SwiftUI

struct ContactDetailView: View {
    
    let contact: Contact
    
    var body: some View {
        List {
            
            Section("General") {
                
                LabeledContent {
                    Text(contact.email)
                } label: {
                    Text("Email")
                }
                
                LabeledContent {
                    Text(contact.phoneNumber)
                } label: {
                    Text("Phone Number")
                }
                
                LabeledContent {
                    Text(contact.dob, style: .date)
                } label: {
                    Text("Birthday")
                }
                
            }
            
            Section("Notes") {
                Text(contact.notes)
            }
        }
        .navigationTitle(contact.formattedName)
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContactDetailView(contact: .preview())
        }
    }
}
