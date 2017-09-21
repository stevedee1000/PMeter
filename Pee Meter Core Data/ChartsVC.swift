//
//  ChartsVC.swift
//  Pee Meter Core Data
//
//  Created by Stephen Desterhaft on 9/13/17.
//  Copyright © 2017 Stephen Desterhaft. All rights reserved.
//

import UIKit
import CoreData
import Charts

class ChartsVC: UIViewController, NSFetchedResultsControllerDelegate {
    
    var controller: NSFetchedResultsController<InOutData>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptFetch()
        
        //print(context.value(forKey: "cVOut") as Any)

    }
    
    func attemptFetch () {
        
        let fetchRequest: NSFetchRequest<InOutData> = InOutData.fetchRequest()
        let dateSort = NSSortDescriptor(key: "dateTime", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            
            try controller.performFetch()
            
        }catch {
            
            let error = error as NSError
            print("\(error)")
            
        }
        
    }

}
