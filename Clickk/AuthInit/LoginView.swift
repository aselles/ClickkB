//
//  LoginView.swift
//  Clickk
//
//  Created by Adão Selles Junior on 12/07/23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var auth: Auth
    
    @State private var email: String = "adao.selles@gmail.com"
    @State private var username: String = "adao.selles"
    @State private var password: String = "teste123"
    
    @State private var showErrorAlert = false
    @State private var errorText = ""
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    Text("Clickk".uppercased())
                        .scaledToFit()
                        .frame(width: 220, height: 100)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    VStack {
                        //E-mail
                        HStack {
                            Image(systemName: "mail")
                            TextField("username", text: $username)
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                        
                        //Senha
                        HStack {
                            Image(systemName: "lock")
                            SecureField("Senha", text: $password)
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
                    }
                    .padding()
                    
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Image(systemName: "info.circle")
//
//                            Text("Esta plataforma é protegida e ao acessá-la você concorda com os")
//                        }
//
//                        HStack {
//                            NavigationLink(destination: TermsOfUseView().navigationBarBackButtonHidden(true)) {
//                                Text("Termos de Uso")
//                                    .underline()
//                            }
//
//                            Text("e")
//
//                            NavigationLink(destination: PrivacyPolicyView().navigationBarBackButtonHidden(true)) {
//                                Text("Política de Privacidade.")
//                                    .underline()
//                            }
//                        }
//
//                        Text("Garantimos a segurança e confidencialidade dos seus dados para proporcionar uma experiência confiável e segura.")
//                    }
//                    .font(.caption)
//                    .padding(10)
                    
                    Button(action: {
                        auth.login(
                            username: username,
                            password: password
                        )

                    }) {
                        HStack {
                            Spacer()
                            Text("Login")
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(Color.blue.opacity(0.5))
                        .cornerRadius(10)
                        .shadow(radius: 3, x: 0, y: 2)
                    }
                    .padding()
                    
                    //BOTÃO RECUPERAR SENHA
                    NavigationLink(destination: ForgotPasswordView().navigationBarBackButtonHidden(true)) {
                        Text("Recuperar Senha")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Text("Ainda não possui uma conta?")

                            Button {
                                auth.showNewAccountView()
                            } label: {
                                Text("Criar agora")

                            }
                            
                        }
                        
                        Text("Copyright @ Clickk Operações Digitais")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .layoutPriority(1)
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Erro ao Autenticar"), message: Text("E-mail ou senha incorretos. Por favor, verifique e tente novamente."), dismissButton: .default(Text("OK")))
        }
    }
}
