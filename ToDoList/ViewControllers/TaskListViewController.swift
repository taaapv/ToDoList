//
//  ViewController.swift
//  ToDoList
//
//  Created by Татьяна on 11.02.2023.
//

import UIKit

final class TaskListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	private var sectionForTaskManager: ISectionForTaskManager!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "To Do List"
		setup()
	}
	
	private func setup() {
		let taskManager: ITaskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasksToTaskList(tasks: repository.createTasks())
		sectionForTaskManager = SectionForTaskManagerAdapter(taskManager: taskManager)
	}
}

extension TaskListViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		sectionForTaskManager.getTitleForSections().count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		sectionForTaskManager.getTitleForSections()[section]
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		sectionForTaskManager.getTasksForSections(section: section).count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
		var context = cell.defaultContentConfiguration()
		
		let currentTask = sectionForTaskManager.getTasksForSections(section: indexPath.section)[indexPath.row]
		
		context.text = currentTask.title
		
		switch currentTask {
		case is RegularTask:
			context.text = currentTask.title
		case is ImportantTask:
			let task = currentTask as! ImportantTask
			context.text = task.priority.description + " " + task.title
			context.secondaryText = "Deadline: " + (task.dateOfCompletion?.formatted() ?? "unknown date")
			
			if let dateOfCompletion = task.dateOfCompletion, dateOfCompletion < Date() {
				cell.backgroundColor = .systemPink
			}
		default:
			break
		}
		cell.accessoryType = currentTask.completed ? .checkmark : .none
		cell.contentConfiguration = context
		return cell
	}
	
}

extension TaskListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let currentTask = sectionForTaskManager.getTasksForSections(section: indexPath.section)[indexPath.row]
		currentTask.completed.toggle()
		tableView.reloadData()
	}
}
