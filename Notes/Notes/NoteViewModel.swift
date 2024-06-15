//
//  NoteViewModel.swift
//  Notes
//
//  Created by Justin Baik on 6/15/24.
//
import FirebaseCore
import FirebaseFirestore
import Foundation

class NoteViewModel : ObservableObject {
    
    @Published private(set) var notes = [NoteModel]()
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
}
