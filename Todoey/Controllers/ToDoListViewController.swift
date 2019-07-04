//
//  ViewController.swift
//  Todoey
//
//  Created by Juan David  Perafan on 6/25/19.
//  Copyright © 2019 Juan David  Perafan. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController : UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
//    USE DEFAULTS TO SAVE SOME DATA IN THE PLIST FILE OF THE APP. THIS IS CREATED USED DEFAULTS, BUT THE DATA MUST BE SHORT AND SMALL
//    let defaults = UserDefaults.standard
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    // THIS CONSTANT IS CREATED FOR SAVE THE DATA WHEN THE APP IS CLOSED AND MAKE THIS PERSISTANT
    //let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
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
//        THIS IS USED TO MAKE THE REQUEST TO THE DATA AND FETCH THIS
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        loadItems(with: request)
        //loadItems()
        
        
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
        
        //IN CORE DATA USES .SETVALUE TO UPDATE DE VALUE OF THE ITEM. IN THIS CASE THE CODE LINE IS:
        //itemArray[indexpath.row].setValue("Completed", forKey:"title") WHERE COMPLETED IS THE STRING NAME FOR THE CHECK AND TITLE THE NAME IN THE DATABASE
        
//        THIS LINES DELETE TEH DATA FROM CORE DATA, FIRST DELETE THE DATA IN THE DB AND AFTER FROM THE LIST
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
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
            
            //let newItem = Item()
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            
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
        //let encoder = PropertyListEncoder()
        
        do{
            try context.save()
//            let data = try encoder.encode(itemArray)
//            try data.write(to: dataFilePath!)
//            tableView.reloadData()
        }catch{
            print("Error saving context \(error)")
//            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//        request.predicate = compoundPredicate
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data form context \(error)")
        }
        tableView.reloadData()
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            }catch {
//               print("Error decoding item Array, \(error)")
//            }
//        }

    }
    
    
    
}
//MARK: - SEARCH BAR METHODS
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//        request.sortDescriptors = [sortDescriptor]
        
//        do{
//            itemArray = try context.fetch(request)
//        }catch{
//            print("Error fetching data from Context \(error)")
//        }
        loadItems(with: request, predicate: predicate)
        
//        tableView.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}

