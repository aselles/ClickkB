//
//  ConfirmationView.swift
//  Clickk
//
//  Created by Adão Selles Junior on 12/07/23.
//

import SwiftUI

struct ConfirmationView: View {
    
    @EnvironmentObject var auth: Auth
    
    @State var confirmationCode = ""
    
    let username: String
    
    var body: some View {
        VStack {
            Text("Username: \(username)")
            TextField("Confirmar Código: ", text: $confirmationCode)
            
            Button {
                auth.confirm(
                    username: username,
                    code: confirmationCode)
            } label: {
                Text("Confirmar")
            }

        }
        
    }
}
