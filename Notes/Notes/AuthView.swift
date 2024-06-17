//
//  AuthView.swift
//  Notes
//
//  Created by Justin Baik on 6/15/24.
//

import SwiftUI

struct AuthView: View {
    @State private var currentViewShowing: String = "login"
    var body: some View {
        if(currentViewShowing == "login") {
            NoteAppLogin(currentShowingView: $currentViewShowing)
        } else {
            SignUpView(currentShowingView: $currentViewShowing)
                .transition(.move(edge: .bottom))
        }
    }
}

#Preview {
    AuthView()
}
