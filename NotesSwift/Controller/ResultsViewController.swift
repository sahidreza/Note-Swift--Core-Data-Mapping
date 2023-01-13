//
//  ViewController.swift
//  NotesSwift
//
//  Created by Sahid Reza on 12/01/23.
//

import UIKit
import CoreData

class ResultsViewController: UIViewController {
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var listTableViewSearchBar: UISearchBar!
    
    
    var listOfPeople = [ItemModel]()
   var selectedCatagory:Catagory? {
        
        didSet{
        
            fetchRequest()
        }
        
    }
    
    var addTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableViewSearchBar.delegate = self
        listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "listTableViewCell")
                let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                print(filePath)
    }
    
    
    @IBAction func barbuttonPressed(_ sender: UIBarButtonItem) {
        
        addAlert()
    }
    

}


// MARK: - Table View Data Source

extension ResultsViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listOfPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell", for: indexPath) as! ListTableViewCell
        
        let indexOfList = listOfPeople[indexPath.row]
        cell.nameLabel.text = indexOfList.itemTitle
        cell.accessoryType =  indexOfList.itemStatus ? .checkmark : .none

        return cell
    }
    
    
}

  // MARK: - TableView Delegate

extension ResultsViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listOfPeople[indexPath.row].itemStatus = !listOfPeople[indexPath.row].itemStatus
        PresesTanceStorage.shared.saveContext()
        self.listTableView.reloadData()
        self.listTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

// MARK: - UISearchBarDelegate

extension ResultsViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        if listTableViewSearchBar.text != "" {
        
            let searchText = listTableViewSearchBar.text!
            let request:NSFetchRequest<ItemModel> = ItemModel.fetchRequest()
            let predicate = NSPredicate(format: "itemTitle CONTAINS[cd] %@", searchText)
            let sortDescrpt = NSSortDescriptor(key: "itemTitle", ascending: true)
            request.sortDescriptors = [sortDescrpt]
            fetchRequest(with: request, predicate: predicate)
            
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0{
            
            fetchRequest()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
           
           
        }
    }
    
}








// MARK: - Alert Controller

extension ResultsViewController{
    
    func addAlert(){
        
        let alert = UIAlertController(title: "Alert", message: "Please Add name", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){(alert) in
            
            if self.addTextField.text != "" {
                
                let newItem = ItemModel(context: PresesTanceStorage.shared.context)
                newItem.itemTitle = self.addTextField.text!
                newItem.itemStatus = false
                newItem.parentCatagory = self.selectedCatagory!
                PresesTanceStorage.shared.saveContext()
                self.listOfPeople.append(newItem)
                self.listTableView.reloadData()
                
            }
        }
        
        alert.addTextField {(textfield) in
            
            textfield.placeholder = "Please add item"
            self.addTextField = textfield
            
            
        }
        
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
}

// MARK: - Fetch Request to Core Data

extension ResultsViewController{
    
    
    func fetchRequest(with request:NSFetchRequest<ItemModel> = ItemModel.fetchRequest(),predicate:NSPredicate? = nil){
        
        let catagoryPrdicate = NSPredicate(format: "parentCatagory.catagoryName MATCHES %@", selectedCatagory!.catagoryName!)
        
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [catagoryPrdicate,additionalPredicate])
        }else{
            request.predicate = catagoryPrdicate
        }
        
        do{
            
            let fetchData = try PresesTanceStorage.shared.context.fetch(request)
            self.listOfPeople = fetchData
            
        }catch{
            print(error)
        }
        
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
        
    }
    
}
