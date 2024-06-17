//
//  NoteViewModel.swift
//  Notes
//
//  Created by Justin Baik on 6/15/24.
//
import FirebaseCore
import FirebaseFirestore
import Foundation
import FirebaseAuth

class NoteViewModel : ObservableObject {
    
    @Published var notes = [NoteModel]()
    let db = Firestore.firestore()
    
    func fetchData() {
        self.notes.removeAll()
        db.collection("notes")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.notes.append(try document.data(as: NoteModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
    }
    
    func saveData(note: NoteModel) {
        
        if let id = note.id {
            //Edit note
            let docRef = db.collection("notes").document(id)
            docRef.updateData([
                "title": note.title,
                "notesdata": note.notesdata
            ]) { err in
                if let err = err {
                    print("Error updating document : \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        } else {
            //Add note
            if !note.title.isEmpty || !note.notesdata.isEmpty {
                var newDocRef: DocumentReference? = nil
                newDocRef = db.collection("notes").addDocument(data: [
                    "title": note.title,
                    "notesdata": note.notesdata
                ]) { err in
                    if let err = err {
                        print("Error adding document : \(err)")
                    } else {
                        print("Document added with: \(newDocRef!.documentID)")
                    }
                }
            }
        }
    }
}
