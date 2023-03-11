//
//  ViewController.swift
//  ToDoList
//
//  Created by Татьяна on 11.02.2023.
//

import UIKit

/// Protocol to Task List View Controller
protocol ITaskListViewController: AnyObject {
	
	/// render data
	/// - Parameter viewData: Structure View Data with data to present
	func render(viewModel: TaskListModels.ViewModel)
}

/// Main  class Task List View Controller
final class TaskListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var interactor: ITaskListInteractor?
	private var viewModel: TaskListModels.ViewModel = TaskListModels.ViewModel(
		tasksSortedBySections: []
	)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "To Do List"
		interactor?.viewLoaded()
	}
}

extension TaskListViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.tasksSortedBySections.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewModel.tasksSortedBySections[section].title
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewModel.tasksSortedBySections[section]
		return section.tasks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: "taskCell",
			for: indexPath
		)
		let tasks = viewModel.tasksSortedBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		
		var content = cell.defaultContentConfiguration()
		
		switch taskData {
		case .regularTask(let task):
			content.text = task.name
			cell.accessoryType = task.isDone ? .checkmark : .none
		case .importantTask(let task):
			let redTextAttributed = [NSAttributedString.Key.foregroundColor: UIColor.red]
			let taskText = NSMutableAttributedString(string: "\(task.priority)", attributes: redTextAttributed)
			taskText.append(NSAttributedString(string: task.name))
			
			content.attributedText = taskText
			content.secondaryText = task.deadline
			content.secondaryTextProperties.color = task.isOverdue ? .red : .black
			cell.accessoryType = task.isDone ? .checkmark : .none
		}
		
		cell.tintColor = .red
		content.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		cell.contentConfiguration = content
		return cell
	}
	
}

extension TaskListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		interactor?.taskSelected(at: indexPath)
	}
}

extension TaskListViewController: ITaskListViewController {
	
	func render(viewModel: TaskListModels.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}
