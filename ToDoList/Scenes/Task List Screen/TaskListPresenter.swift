//
//  ITaskListPresenter.swift
//  ToDoList
//
//  Created by Татьяна on 18.02.2023.
//

import Foundation

protocol ITaskListPresenter {
	func presentViewData(viewData: TaskListViewModel.ViewData)
}

final class TaskListPresenter: ITaskListPresenter {

	
	private weak var view: ITaskListViewController?
	
	init(view: ITaskListViewController) {
		self.view = view
	}
	
	func presentViewData(viewData: TaskListViewModel.ViewData) {
		view?.render(viewData: viewData)
	}
}
