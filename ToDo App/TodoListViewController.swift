//
//  ViewController.swift
//  ToDo App
//
//  Created by Josh Levine on 7/21/19.
//  Copyright © 2019 Josh Levine. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Task]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        
        // Do any additional setup after loading the view.
//        let newTask = Task(title: "Task 1")
//        
//        itemArray.append(newTask)
        // Do any additional setup after loading the view.
//        if let items = defaults.array(forKey: "ToDoListArray2") as? [Task] {
//            itemArray = items
        loadTasks()
            print("array updated")

    //}
    
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        // let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        
        cell.accessoryType = itemArray[indexPath.row].complete ? .checkmark : .none
        

        
        
        return cell
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].complete = !(itemArray[indexPath.row].complete)
        
        saveData()
        
        
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
//
//            if let items = self.defaults.array(forKey: "TodoArray") as? [Task] {
//                self.itemArray = items
//                print("array updated")
            let newTask = Task(title: textField.text!)
            self.itemArray.append(newTask)
//
            self.saveData()
//
            
            
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
    
    func saveData(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    func loadTasks() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Task].self, from: data)
        } catch {
            print("Error decoding task array: \(error)")
        }
        }
    }
    
    }
    



