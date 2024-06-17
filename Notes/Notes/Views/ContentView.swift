//
//  ContentView.swift
//  Notes
//
//  Created by Justin Baik on 6/15/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @AppStorage("uid") var userID : String = ""
    
    @StateObject var noteApp = NoteViewModel()
    @State var note = NoteModel(title: "", notesdata: "")
    
    var body: some View {
        
        if userID == "" {
            AuthView()
        } else {
            NavigationStack {
                
                List {
                    ForEach($noteApp.notes) { $note in
                        NavigationLink {
                            NoteDetail(note: $note)
                        } label: {
                            Text(note.title)
                        }
                    }
                    Section {
                        NavigationLink {
                            NoteDetail(note: $note)
                        } label: {
                            Text("New note")
                        }
                    }
                    
                    Button(action: {
                        let firebaseAuth = Auth.auth()
                        do {
                            try firebaseAuth.signOut()
                            userID = ""
                        } catch let signOutError as NSError {
                            print("Error signingout: %@", signOutError)
                        }
                    }) {
                        Text("Sign Out")
                    }
                }
                .onAppear{
                    noteApp.fetchData()
                }
                .refreshable{
                    noteApp.fetchData()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
