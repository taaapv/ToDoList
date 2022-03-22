//
//  EditNoteViewController.swift
//  ToDoList
//
//  Created by Татьяна on 22.03.2022.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    public var note: String = ""
    public var index: Int = 0
    
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 10
        noteTF.text = note
    }
    
    @IBAction func pressSaveButton(_ sender: Any) {
    }
    
    // MARK: - Navigation

    // Передача данных через segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! TableViewController
        notes.remove(at: index)
        notes.insert(noteTF.text!, at: index)
        dest.tableView.reloadData()

    }

}
