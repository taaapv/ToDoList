//
//  TaskListRouter.swift
//  ToDoList
//
//  Created by Татьяна on 22.02.2023.
//

import Foundation

protocol TaskListDataPassing {
	var dataStore: TaskListDataStore? { get }
}

class TaskListRouter: TaskListDataPassing {
	weak var view: TaskListViewController?
	var dataStore: TaskListDataStore?
	
	init(view: TaskListViewController, dataStore: TaskListDataStore) {
		self.view = view
		self.dataStore = dataStore
	}
}
