//
//  ViewController.swift
//  Todoey
//
//  Created by Efrat bitton on 7/18/18.
//  Copyright © 2018 Yahav Bitton. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        
        loadItems()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //MARK - TableView Datasource Methods numberOfRowsInSection and cellForRowAt
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = item.title
        
        
        if item.done == true {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
        
    }
    
    
    //MARK - TableView Delegate Methods
    //What to do when cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //If its true make it false, if its false make it true
        if itemArray[indexPath.row].done == false{
            itemArray[indexPath.row].done = true
        }else{
            itemArray[indexPath.row].done = false
        }
        
        saveItems()
        
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
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
            
            let newItem = Item()
            
            newItem.title = textField.text!
           
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            print("Wrote to file correctly")
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch{
            print("Error encoding Item Array, \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error Decoding, \(error)")
            }
            
        }
        
    }
    
    
    
    
    

}

