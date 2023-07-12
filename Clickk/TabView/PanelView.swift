//
//  PanelView.swift
//  Clickk
//
//  Created by Adão Selles Junior on 12/07/23.
//

import SwiftUI

struct PanelView: View {
    
    @EnvironmentObject var auth: Auth
    
    var body: some View {
        
        Button {
            auth.signOut()
        } label: {
            Text("Sair")
        }

        
        
        
    }
    
    
    
}

struct PanelView_Previews: PreviewProvider {
    static var previews: some View {
        PanelView()
    }
}
