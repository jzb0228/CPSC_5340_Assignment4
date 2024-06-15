//
//  ContentView.swift
//  Notes
//
//  Created by Justin Baik on 6/15/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var noteApp = NoteViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(noteApp.notes) { note in
                    NavigationLink {
                        NoteDetail(note: note)
                    } label: {
                        Text(note.title)
                    }
                }
            }
            .onAppear{
                noteApp.fetchData()
            }
        }
    }
}

#Preview {
    ContentView()
}
