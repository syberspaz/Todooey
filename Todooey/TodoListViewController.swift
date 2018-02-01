//
//  ViewController.swift
//  Todooey/Users/hogue/Documents/Todooey/Todooey/TodoListViewController.swift
//
//  Created by Andrew Hogue on 2018-02-01.
//  Copyright © 2018 Andrew Hogue. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let defaults = UserDefaults.standard
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        print(dataFilePath!)
        
        loadItems()
        
    }

    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func loadItems() {
     
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("error fetching data: \(error)")
        }
        
    }
    
        
    func saveItems() {
          do{
            
           try self.context.save();
          } catch {
            print("error saving context")
          }
        //  self.defaults.set(self.itemArray, forKey: "TodoListArray")
        self.tableView.reloadData()
    }
    //MARK - Tableview Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("selected\(indexPath.row): \(itemArray[indexPath.row])")
        let accType = tableView.cellForRow(at: indexPath)?.accessoryType
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        if(accType == .checkmark) {
         tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK - Add items button
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todooey Item", message: "", preferredStyle: .alert)
        var textfield : UITextField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when user clicks add item button on ui alert
          
            let newItem = Item(context: self.context)
            newItem.title = textfield.text!
            newItem.done = false;
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textfield = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

