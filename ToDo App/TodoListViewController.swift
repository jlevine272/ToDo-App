//
//  ViewController.swift
//  ToDo App
//
//  Created by Josh Levine on 7/21/19.
//  Copyright © 2019 Josh Levine. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [String]()
    
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let newTask = "Task 1"
        
        itemArray.append(newTask)
        // Do any additional setup after loading the view.
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
            print("array updated")

    }
        else {
            print("Couldn't find array")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        // let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//            let newTask = Task(title: textField.text!)
//
//            self.itemArray.append(newTask)
//
//            if let items = self.defaults.array(forKey: "TodoArray") as? [Task] {
//                self.itemArray = items
//                print("array updated")

            self.itemArray.append(Task(title: textField.text!))
//
            
//
            self.tableView.reloadData()
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            }
//            else {
//                print("update failed")
//            }
        
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Item"
            textField = alertTextField

    }
    
        
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
    }
    }
    



