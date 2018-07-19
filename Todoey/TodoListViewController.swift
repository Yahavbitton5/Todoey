//
//  ViewController.swift
//  Todoey
//
//  Created by Efrat bitton on 7/18/18.
//  Copyright © 2018 Yahav Bitton. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demagorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //MARK - TableView Datasource Methods numberOfRowsInSection and cellForRowAt
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    
    //MARK - TableView Delegate Methods
    //What to do when cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
                
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        //How to deselect a row
        tableView.deselectRow(at: indexPath, animated: true)
        
         
        
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //First add the controller, then the action, then add the action to alert, and finally present
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //What will happen once the user clicks the add item button on our UIAlert
            print(textField.text!)
            self.itemArray.append(textField.text!)
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    

}

