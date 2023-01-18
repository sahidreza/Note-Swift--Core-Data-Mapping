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
    
    private let catagoryManger = CatagoryManager()
    
    
    var listOfPeople = [ItemModel]()
    var selectedCatagory:CatagoryModel? {
        
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


//MARK: - Table View Data Source

extension ResultsViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listOfPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell", for: indexPath) as! ListTableViewCell
        
        let indexOfList = listOfPeople[indexPath.row]
        cell.nameLabel.text = indexOfList.ItemName
        //  cell.accessoryType =  indexOfList.ItemStatus ? .checkmark : .none
        
        return cell
    }
    
    
}

// MARK: - TableView Delegate

extension ResultsViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        listOfPeople[indexPath.row].itemStatus = !listOfPeople[indexPath.row].itemStatus
    //        PresesTanceStorage.shared.saveContext()
    //        self.listTableView.reloadData()
    //        self.listTableView.deselectRow(at: indexPath, animated: true)
    //
    //    }
    
}

// MARK: - UISearchBarDelegate

extension ResultsViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if listTableViewSearchBar.text != "" {
            
            if listOfPeople.count != 0{
                
                var newItemList = [ItemModel]()
                
                listOfPeople.forEach { itemModel in
                    
                    if itemModel.ItemName.uppercased().contains(listTableViewSearchBar.text!.uppercased()){
                        
                        newItemList.append(itemModel)
                    }
                    
                }
                
                listOfPeople = newItemList
                self.listTableView.reloadData()
                
            }
            
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
                
                if let catagoryData = self.selectedCatagory{
                    
                    let itemData = ItemModel(ItemName: self.addTextField.text!, ItemID: UUID(), ItemStatus: false)
                    
                    let newCatagoryData = CatagoryModel(catagoryID: catagoryData.catagoryID, catagoryTitle: catagoryData.catagoryTitle,catagorysItem: itemData)
                    
                    self.catagoryManger.createCatagoryDatawithItem(record: newCatagoryData)
                    self.listOfPeople.append(itemData)
                    self.listTableView.reloadData()
                    
                    
                    
                }
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
    
    func fetchRequest(){
        
        if let catagoryData = selectedCatagory{
            
            let itemData = catagoryManger.fetchItemData(title: catagoryData.catagoryTitle)
            if let safeData = itemData{
                listOfPeople = safeData
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                    
                }
            }
            
       
        }
        
        
    }
    
}
