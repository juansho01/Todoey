//
//  ViewController.swift
//  Todoey
//
//  Created by Juan David  Perafan on 6/25/19.
//  Copyright © 2019 Juan David  Perafan. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {
    
    var itemArray = ["find Mike", "Buy Eggs", "Destroy Demogorgon"]
    
    // THIS CONSTANT IS CREATED FOR SAVE THE DATA WHEN THE APP IS CLOSED AND MAKE THIS PERSISTANT
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource Methods
    // METHOD FOR DISPLAY THE CONTENT OF THE ARRAY IN CELLS ON THE TABLE
    
    // COUNT THE ITEMS OF THE ARRAY
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    // DISPLAY THE ITEMS IN THE TABLEVIEW
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //CREATE A CUSTOM CELL BASED ON THE ID OF THE CELL IN THE MAIN STORYBOARD
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - Tableview Daelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //ADD AN ACCESORY - CHECKMARK
                
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        // CHANGE THE DEFAUKT GRAY WHEN THE CELL IS TOUCH
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - ADD NEW ITEMS
    // ADD BUTTON FOR ADD TASK TO THE LIST
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        //CREATE THE ALERT MESSAGE FOR ADD NEW ITEM
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        // THIS CREATE THE ACTION WHEN THE BUTTON IS PRESSED
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //WHAT WILL APPEN WHEN THE USER CLICK THE ADD BUTTON
            //PRINT THE TEXT OF THE TEXT FIELD
            //print(textField.text!)
            
            // THE SIMBOL ! WAS USED TO UNWRAP THE CONTENT AND THIS IS NOT NIL, BUT IF IS NIL THE CODE WAS: (textTield.text ?? "New item") WHERE NEW ITEM IS A DEFAULT TEXT
            
            // THIS LINE APPEND THE TEXT WRITEN ON THE TEXT FIELD
            self.itemArray.append(textField.text!)
            
            //THIS IS USED FOR SHOW THE USER THE PERSISTENT DATA - SEND TO THE CONSTANT DEFAULTS THE DATA
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            // THIS LINE IS FOR THE TABLE RELOAD THE DATA AND DISPLAY THE TEXT WRITEN ON THE TEXT FIELD
            self.tableView.reloadData()
        }
        // THIS CREATE A TEXT FIELD IN THE ALERT MESSAGE
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    

}

