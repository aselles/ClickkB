//
//  LoginViewModel.swift
//  Clickk
//
//  Created by Adão Selles Junior on 12/07/23.
//

import Amplify

enum AuthState {
    case newAccount
    case login
    case confirmCode(username: String)
    case session(user: AuthUser)
}

final class Auth: ObservableObject {
    @Published var authState: AuthState = .login
    
    func getCurrentAuthUser() {
        if let user = Amplify.Auth.getCurrentUser() {
            authState = .session(user: user)
        } else {
            authState = .login
        }
    }
    
    func showNewAccountView() {
        authState = .newAccount
    }
    
    func showLoginView() {
        authState = .login
    }
    
    func newAccount(username: String, email: String, password: String) {
        let attributers = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: attributers)
        
        _ = Amplify.Auth.signUp(
            username: username,
            password: password,
            options: options
        ) { [weak self] result in
            switch result {
            case .success(let signUpResult):
                print("Sign Up Result: ", signUpResult)
                
                switch signUpResult.nextStep {
                case .done:
                    print("Login Concluido")
                    
                case .confirmUser(let details, _):
                    print(details ?? "sem detalhes")
                    
                    DispatchQueue.main.async {
                        self?.authState = .confirmCode(username: username)
                    }
                }
            case .failure(let error):
                print("Signup Error: ", error)
            }
        }
    }
    
    func confirm(username: String, code: String) {
        _ = Amplify.Auth.confirmSignUp(
            for: username,
            confirmationCode: code
        ) { [weak self] result in
            
            switch result {
                
            case .success(let confirmResult):
                print(confirmResult)
                if confirmResult.isSignupComplete {
                    DispatchQueue.main.async {
                        self?.showLoginView()
                    }
                }
                
                
            case .failure(let error):
                print("falha em conf. code", error)
            }
            
        }
    }
    
    func login(username: String, password: String) {
        _ = Amplify.Auth.signIn(
            username: username,
            password: password
        ) { [weak self] result in
            
            switch result {
            case .success(let signInResult):
                print(signInResult)
                
                if signInResult.isSignedIn {
                    DispatchQueue.main.async {
                        self?.getCurrentAuthUser()
                    }
                }
            
            case .failure(let error):
                print("falha em login: ", error)
            }



        }
    }
    
    func signOut() {
        _ = Amplify.Auth.signOut() { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.getCurrentAuthUser()
                }
                
            case .failure(let error):
                print("Falha em deslogar", error)
            }
        }
    }
}
