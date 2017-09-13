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

        myDatePicker.backgroundColor = (UIColor.init(red: 0.65, green: 0.89, blue: 0.91, alpha: 0.82))
        myDatePicker.setValue(UIColor.red, forKey: "textColor")
        
        navigationController?.navigationBar.tintColor = UIColor.red
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "Data Table", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        if itemToEdit != nil {
            
            loadItemData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        var item: InOutData!
        
        //Saving new item or modified item??
        if itemToEdit == nil {
            item = InOutData(context: context)
        } else {
            item = itemToEdit
        }
        
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
        
        //self.tabBarController?.selectedIndex = 0
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
    }
}




