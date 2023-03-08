//
//  TaskListRouter.swift
//  ToDoList
//
//  Created by Татьяна on 22.02.2023.
//

import Foundation

protocol TaskListDataPassing {
	var dataStore: ITaskListDataStore? { get }
}

class TaskListRouter: TaskListDataPassing {
	weak var view: TaskListViewController?
	var dataStore: ITaskListDataStore?
	
	init(view: TaskListViewController, dataStore: ITaskListDataStore) {
		self.view = view
		self.dataStore = dataStore
	}
}
