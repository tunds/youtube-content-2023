//
//  CreateContactView.swift
//  MyRideOrDies
//
//  Created by Tunde Adegoroye on 10/12/2022.
//

import SwiftUI

struct CreateContactView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm: EditContactViewModel
    
    @State private var hasError: Bool = false

       var body: some View {
           List {
               
               Section("General") {
                  
                   TextField("Name", text: $vm.contact.name)
                                       .keyboardType(.namePhonePad)

                   TextField("Email", text: $vm.contact.email)
                       .keyboardType(.emailAddress)

                   TextField("Phone Number", text: $vm.contact.phoneNumber)
                       .keyboardType(.phonePad)

                   DatePicker("Birthday",
                              selection: $vm.contact.dob,
                              displayedComponents: [.date])
                   .datePickerStyle(.compact)
                   
                   Toggle("Favourite", isOn: $vm.contact.isFavourite)
                   
               }
               
               Section("Notes") {
                   TextField("",
                             text: $vm.contact.notes,
                             axis: .vertical)
               }
           }
           .navigationTitle(vm.isNew ? "New Contact" : "Update Contact")
           .toolbar {
               ToolbarItem(placement: .confirmationAction) {
                   Button("Done") {
                       validate()
                   }
               }
               
               ToolbarItem(placement: .navigationBarLeading) {
                   Button("Cancel") {
                       dismiss()
                   }
               }
           }
           .alert("Something aint right",
                  isPresented: $hasError,
                  actions: {}) {
               Text("It looks like your form is invalid")
           }

       }
}

private extension CreateContactView {
    
    func validate() {
        if vm.contact.isValid {
            do {
                try vm.save()
                dismiss()
            } catch {
                print(error)
            }
        } else {
            hasError = true
        }
    }
}

struct CreateContactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            let preview = ContactsProvider.shared
            CreateContactView(vm: .init(provider: preview))
                .environment(\.managedObjectContext, preview.viewContext)
        }
    }
}
