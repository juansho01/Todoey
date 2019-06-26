//
//  ViewController.swift
//  Todoey
//
//  Created by Juan David  Perafan on 6/25/19.
//  Copyright © 2019 Juan David  Perafan. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {
    
    let itemArray = ["find Mike", "Buy Eggs", "Destroy Demogorgon"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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

}

