//
//  Model.swift
//  ToDoList
//
//  Created by Татьяна on 18.03.2022.
//

import Foundation

var notes: [String] {
    set {
        UserDefaults.standard.set(newValue, forKey: "notesData")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let newNotes = UserDefaults.standard.array(forKey: "notesData") as? [String] {
            return newNotes
        } else {
            return []
        }
    }
}

func addItem(nameItem: String) {
    notes.append(nameItem)
}

func removeItem(at index: Int) {
    notes.remove(at: index)
}

func insertItem(nameItem: String, at index: Int) {
    notes.insert(nameItem, at: index)
}

func moveItem(from: Int, to: Int) {
    let fromItem = notes[from]
    notes.remove(at: from)
    notes.insert(fromItem, at: to)
}
