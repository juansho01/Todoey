//
//  ViewController.swift
//  Todoey
//
//  Created by Juan David  Perafan on 6/25/19.
//  Copyright © 2019 Juan David  Perafan. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {
    
    var itemArray = [Item]()
    
//    USE DEFAULTS TO SAVE SOME DATA IN THE PLIST FILE OF THE APP. THIS IS CREATED USED DEFAULTS, BUT THE DATA MUST BE SHORT AND SMALL
//    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    // THIS CONSTANT IS CREATED FOR SAVE THE DATA WHEN THE APP IS CLOSED AND MAKE THIS PERSISTANT
    //let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //print(dataFilePath)
        
        
        // DYNAMIC CREATION OF ITEMS BASED ON THE CLAS: "ITEM" IN DATA MODEL
//        let newItem = Item()
//        newItem.title = "find Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggs"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Destory Demogorgon"
//        itemArray.append(newItem3)
        
        loadItems()
        
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
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
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //TENUARY OPERATOR ==>
        //VALUE = CONDITION ? VALUEIF TRUE : VALUEIFFALSE THIS REPLACE THE IF CONDITION
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        // A SHORT FORM ITS: cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - Tableview Daelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        //FUNCTION TO CHECK OPPOSITES: THE CHECKMARK FUNCTION IS BASED ON BOOLEAN: TRUE OR FALSE, SO BETTER THAN IF AND ELSE, USE THE EXPRESSION = ! (IF ISNT EQUAL)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false{
//            itemArray[indexPath.row].done = true
//        }else{
//            itemArray[indexPath.row].done = false
//        }
        
        //ADD AN ACCESORY - CHECKMARK
                
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        saveItems()
        
        
        
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
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
            // THE SIMBOL ! WAS USED TO UNWRAP THE CONTENT AND THIS IS NOT NIL, BUT IF IS NIL THE CODE WAS: (textTield.text ?? "New item") WHERE NEW ITEM IS A DEFAULT TEXT
            
            // THIS LINE APPEND THE TEXT WRITEN ON THE TEXT FIELD
            self.itemArray.append(newItem)
            
            //THIS IS USED FOR SHOW THE USER THE PERSISTENT DATA - SEND TO THE CONSTANT DEFAULTS THE DATA
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            //NEW OBJECT OF THE TYPE PROPERTY LIST ENCODER
//            let encoder = PropertyListEncoder()
//
//            do{
//                let data = try encoder.encode(self.itemArray)
//                try data.write(to: self.dataFilePath!)
//            }catch{
//                print("Error encoding item array, \(error)")
//            }
            self.saveItems()
            // THIS LINE IS FOR THE TABLE RELOAD THE DATA AND DISPLAY THE TEXT WRITEN ON THE TEXT FIELD
//            self.tableView.reloadData()
        }
        // THIS CREATE A TEXT FIELD IN THE ALERT MESSAGE
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - MODEL MANIPULATION METHODS
    
    //METHOD FOR SAVE TEH DATA IN THE PLIST LIKE A FUNCTION
    
    func saveItems()  {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            tableView.reloadData()
        }catch{
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch {
               print("Error decoding item Array, \(error)")
            }
        }
        
    }
    
    

}

