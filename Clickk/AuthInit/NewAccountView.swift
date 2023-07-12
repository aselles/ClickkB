//
//  NewAccountView.swift
//  Clickk
//
//  Created by Adão Selles Junior on 12/07/23.
//

import SwiftUI

struct NewAccountView: View {
    
    @EnvironmentObject var auth: Auth
    
    @State var username = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("Username", text: $username)
            TextField("email", text: $email)
            TextField("Password", text: $password)
            
            Button {
                auth.newAccount(
                    username: username,
                    email: email,
                    password: password)
            } label: {
                Text("Cadastrar-se")
            }


            
        }
        
    }
}

struct NewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewAccountView()
    }
}
