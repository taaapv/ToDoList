//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Татьяна on 20.03.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var noteTF: UITextField!
    
    // Передача данных через segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! TableViewController
        if let noteTF = noteTF.text {
            addItem(nameItem: noteTF)
        }
        dest.tableView.reloadData()
    }
}
