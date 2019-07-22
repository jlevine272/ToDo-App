//
//  ViewController.swift
//  ToDo App
//
//  Created by Josh Levine on 7/21/19.
//  Copyright © 2019 Josh Levine. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Task]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults()
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
        

    //}
    
    }
    
    
    //MARK: - TableView Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        // let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        

        
        
        return cell
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        itemArray[indexPath.row].done = !(itemArray[indexPath.row].done)
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
        saveData()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Todoey Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

           
            
            let newTask = Task(context: self.context)
            newTask.title = textField.text!
            newTask.done = false
            self.itemArray.append(newTask)
//
            self.saveData()
//
            
            
            }
        
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Item"
            textField = alertTextField

    }
    
        
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - CoreData Methods
    
    func saveData(){
       // let encoder = PropertyListEncoder()
        
        do {
            try context.save()
            
        } catch {
            print("Error saving context, \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    func loadTasks(with request: NSFetchRequest<Task> = Task.fetchRequest()) {
       
        do{
            itemArray = try context.fetch(request)
        } catch {
            print("error fetching data: \(error)")
        }
        tableView.reloadData()
    }
    
    }


//MARK: - Search Bar Methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        let request : NSFetchRequest<Task> = Task.fetchRequest()
        
        request.predicate = NSPredicate(format: "title Contains[cd] %@", searchBar.text!) //predicate code
        
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        
        loadTasks(with: request)
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadTasks()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
         
        }
    }
    
    
}
    



