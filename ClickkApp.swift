//
//  ClickkApp.swift
//  Clickk
//
//  Created by Adão Selles Junior on 12/07/23.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct ClickkApp: App {
    
    @ObservedObject var auth = Auth()
    
    init() {
        configureAmplify()
        auth.getCurrentAuthUser()
    }
    
    var body: some Scene {
        WindowGroup {
            switch auth.authState {
            case .login:
                LoginView()
                    .environmentObject(auth)
                
            case .newAccount:
                NewAccountView() //signupview
                    .environmentObject(auth)

            case .confirmCode(let username):
                ConfirmationView(username: username)
                    .environmentObject(auth)

            case .session(let user):
                MainTabView(user: user) //homeview
                    .environmentObject(auth)

            }
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify Configurado")

        } catch {
            print("Amplify Não Configurado", error)
        }
    }
    
}
