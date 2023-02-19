//
//  ViewController.swift
//  ToDoList
//
//  Created by Татьяна on 11.02.2023.
//

import UIKit

/// Structure View Data with data to present
struct ViewData {
	var numberOfSection: Int
	var titlesForHeaderInSection: [String]
	var tasksInSections: [Task]
	
	var contentText: String
	var contentSecondaryText: String?
	var cellBackgroundColor: UIColor?
	var cellAccessoryType: UITableViewCell.AccessoryType
}

/// Protocol to Task List View Controller
protocol ITaskListViewController: AnyObject {
	
	/// render data
	/// - Parameter viewData: Structure View Data with data to present
	func render(viewData: ViewData)
}

/// Main  class Task List View Controller
final class TaskListViewController: UIViewController {
	
	/// table View with task list
	@IBOutlet weak var tableView: UITableView!
	
	private var viewData: ViewData!
	private var presenter: ITaskListPresenter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "To Do List"
		configure()
	}
	
	private func configure() {
		let presenter = TaskListPresenter(view: self)
		self.presenter = presenter
		presenter.viewLoaded()
	}
}

extension TaskListViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		viewData.numberOfSection
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewData.titlesForHeaderInSection[section]
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.tasksInSections.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
		var context = cell.defaultContentConfiguration()
		context.text = viewData.contentText
		context.secondaryText = viewData.contentSecondaryText
		cell.backgroundColor = viewData.cellBackgroundColor
		cell.accessoryType = viewData.cellAccessoryType
		cell.contentConfiguration = context
		return cell
	}
	
}

extension TaskListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		presenter.cellTapped(indexPath: indexPath)
		tableView.reloadData()
	}
}

extension TaskListViewController: ITaskListViewController {
	
	/// Render view Data
	/// - Parameter viewData: View Data with data to present
	func render(viewData: ViewData) {
		self.viewData = viewData
		tableView.reloadData()
	}
}
