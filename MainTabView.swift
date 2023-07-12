//
//  MainTabView.swift
//  Clickk
//
//  Created by Adão Selles Junior on 12/07/23.
//

import SwiftUI
import Amplify

struct MainTabView: View {
    
    let user: AuthUser

    @State private var currentTab = 0

    var body: some View {
        TabView(selection: $currentTab) {
            HomeView(user: user)
                .tabItem {
                    Image(systemName: "house")
                    Text("Início")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Buscar")
                }
                .tag(1)
            
            DiscoverView()
                .tabItem {
                    Image(systemName: "safari")
                    Text("Descubra")
                }
                .tag(2)
            
            NotificationsView()
                .tabItem {
                    Image(systemName: "bell")
                    Text("Notificações")
                }
                .tag(3)
            
            PanelView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Paínel")
                }
                .tag(4)
        }
        .accentColor(Color.black)
    }
}

