//
//  ViewController.swift
//  Todooey/Users/hogue/Documents/Todooey/Todooey/TodoListViewController.swift
//
//  Created by Andrew Hogue on 2018-02-01.
//  Copyright © 2018 Andrew Hogue. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Fix things", "Find Things", "Break Things"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - Tableview Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("selected\(indexPath.row): \(itemArray[indexPath.row])")
        let accType = tableView.cellForRow(at: indexPath)?.accessoryType
        
        if(accType == .checkmark) {
         tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK - Add items button
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todooey Item", message: "", preferredStyle: .alert)
        var textfield : UITextField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when user clicks add item button on ui alert
            self.itemArray.append(textfield.text!)
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textfield = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

