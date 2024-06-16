//
//  ContentView.swift
//  Notes
//
//  Created by Justin Baik on 6/15/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var noteApp = NoteViewModel()
    @State var note = NoteModel(title: "", notesdata: "")
    
    var body: some View {
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

#Preview {
    ContentView()
}
