//
//  CatagoryTableViewController.swift
//  NotesSwift
//
//  Created by Sahid Reza on 13/01/23.
//

import UIKit
import CoreData


class CatagoryTableViewController: UITableViewController {
    
    
    @IBOutlet var catagoryTableview: UITableView!
    
    var catagoryList = [CatagoryModel]()
    var catagoryTextField = UITextField()
    let catagoryManager = CatagoryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(filePath)
        loadItem()
        
    }
    
    
    @IBAction func barButton(_ sender: Any) {
        
        createAlert()
    }
    
    
}

// MARK: - Data Source Delegate

extension CatagoryTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return catagoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)
        
        cell.textLabel?.text = catagoryList[indexPath.row].catagoryTitle
        
        return cell
    }
    
}

// MARK: - TableViewDelegate

extension CatagoryTableViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "catagoryToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destionationVc = segue.destination as! ResultsViewController
        if let indexpath = tableView.indexPathForSelectedRow{
            print(catagoryList[indexpath.row],"Abu")
            destionationVc.selectedCatagory = catagoryList[indexpath.row]
            
        }
    }
}

// MARK: - Create a alert

extension CatagoryTableViewController{
    
    func createAlert(){
        
        
        let alertController = UIAlertController(title: "Note", message: "Create your note subject", preferredStyle: .alert)
        let action = UIAlertAction(title: "Save Item", style: .default){(acttion) in
            
            if self.catagoryTextField.text != " "{
                
                let newCatagory = CatagoryModel(catagoryID: UUID(), catagoryTitle: self.catagoryTextField.text!)
                self.catagoryManager.createCatagoryData(with: newCatagory)
                self.catagoryList.append(newCatagory)
                self.catagoryTableview.reloadData()
                
            }
            
            
            
        }
        alertController.addTextField{(textField) in
            
            textField.placeholder = "Create your own notes subject"
            self.catagoryTextField = textField
            
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
        
    }
}

// Load Item for DataBase

extension CatagoryTableViewController{
    
    func loadItem(){
        
        let catagoryData = catagoryManager.fetchCatagoryData()
        
        if let safeData = catagoryData {
            
            self.catagoryList = safeData
            
            DispatchQueue.main.async {
                
                self.catagoryTableview.reloadData()
            }
            
        }
        
       
    }
    
    
}
