//
//  NoteDetail.swift
//  Notes
//
//  Created by Justin Baik on 6/15/24.
//

import SwiftUI

struct NoteDetail: View {
    
    var note : NoteModel
    
    var body: some View {
        VStack {
            Text(note.title)
            Text(note.notesdata)
        }
    }
}

#Preview {
    NoteDetail(note: NoteModel(title: "one", notesdata: "one note"))
}
