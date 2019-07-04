//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Juan David  Perafan on 7/4/19.
//  Copyright © 2019 Juan David  Perafan. All rights reserved.
//  ORDER TO WRITE CODE: VISUALIZATION ITEMS, MANAGE OF DATA AND ACTIONS (BUTTONS EXAMPLE)

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    //MARK: - ADD NEW CATEGORIES
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var  textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategorie = Category(context: self.context)
            newCategorie.name = textField.text!
            self.categories.append(newCategorie)
            self.saveCategories()
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
    }
        
    
    //MARK: - TABLEVIEW DATA SOURCE METHODS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //THE IDENTIFIER MUST BE THE ID OF THE CELL IN THE TABLE ON THE STORYBOARD
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
//        let item = categories[indexPath.row]
//        cell.textLabel?.text = item.name
        
        return cell
        
    }
    
    //MARK: - TABLEVIEW DELEGATE METHODS
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        } 
        
        
    }
    
    
    //MARK: - DATA MANIPULATION METHODS
    func saveCategories() {
        do{
            try context.save()
        }catch{
            print("Error saving categories \(error)")
        }
        self.tableView.reloadData()
    }
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            categories = try context.fetch(request)
        }catch{
            print("Error loading categories \(error)")
        }
        tableView.reloadData()
    }

    
    

    
    
}
