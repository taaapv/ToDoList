//
//  TableViewController.swift
//  ToDoList
//
//  Created by Татьяна on 18.03.2022.
//

import UIKit

class TableViewController: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if notes.isEmpty {
            addItem(nameItem: "This is first note")
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let note = notes[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = note
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let note = notes[indexPath.row]
        let index = indexPath.row
        
        // Передача данных через storyboard
        guard let editNoteVC = storyboard?.instantiateViewController(withIdentifier: "editNote") as? EditNoteViewController else {return}
        editNoteVC.title = "Note"
        editNoteVC.note = note
        editNoteVC.index = index
        show(editNoteVC, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    // Обратная передача данных через unwind segue
    
    @IBAction func pushAddAction(_ unwindSegue: UIStoryboardSegue) {}
    
    @IBAction func pushSaveAction(_ unwindSegue: UIStoryboardSegue) {}

    

}
