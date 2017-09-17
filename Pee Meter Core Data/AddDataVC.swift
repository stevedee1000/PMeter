//
//  AddDataVC.swift
//  Pee Meter Core Data
//
//  Created by Stephen Desterhaft on 12/9/16.
//  Copyright © 2016 Stephen Desterhaft. All rights reserved.
//

import UIKit
import CoreData

class AddDataVC: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var nVOutLabel: UITextField!
    @IBOutlet weak var cVOutLabel: UITextField!
    @IBOutlet weak var inLabel: UITextField!

    var itemToEdit: InOutData?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true

        myDatePicker.backgroundColor = (UIColor.init(red: 24.0/255.0, green: 122.0/255.0, blue: 191.0/255.0, alpha: 1))
        myDatePicker.setValue(UIColor.red, forKey: "textColor")
        
        navigationController?.navigationBar.tintColor = UIColor.red
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        if itemToEdit != nil {
            
            loadItemData()
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        var item: InOutData!
        
        //Saving new item or modified item??
        if itemToEdit == nil {
            item = InOutData(context: context)
        } else {
            item = itemToEdit
        }
        
        if cVOutLabel.text == "" { cVOutLabel.text = "0" } // Make sure
        if nVOutLabel.text == "" { nVOutLabel.text = "0" } // the text fields
        if inLabel.text == "" { inLabel.text = "0" }       // aren't blank
        
        if let cVOut = cVOutLabel.text {
            item.cVOut = Int16(cVOut)!
        }
        
        if let nVOut = nVOutLabel.text {
            item.nVOut = Int16(nVOut)!
        }
        
        if let fIn = inLabel.text {
            item.fIn = Int16(fIn)!
        }
        
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyyMMddHHmm"
        if myDatePicker != nil {
            item.dateTime = myFormatter.string(from: myDatePicker.date)
        }
        
        ad.saveContext()
        
        nVOutLabel.text = "0"
        cVOutLabel.text = "0"
        inLabel.text = "0"
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItemData () {
        
        if let item = itemToEdit {
            
            nVOutLabel.text = "\(item.nVOut)"
            cVOutLabel.text = "\(item.cVOut)"
            inLabel.text = "\(item.fIn)"
            
            //Set the Date Picker
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "yyyyMMddHHmm"
            let pickerDate = myFormatter.date(from: item.dateTime!)
            myDatePicker.setDate(pickerDate!, animated: true)
        }
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // when Nav Back button pressed, make tab Bar Controller reappear
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            self.tabBarController?.tabBar.isHidden = false
        }
    }
}




