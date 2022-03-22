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
