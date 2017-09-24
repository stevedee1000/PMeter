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
    
    var iOData: NSFetchedResultsController<InOutData>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptFetch()
        

//        for record in 0 ..< (iOData.fetchedObjects?.count)! { //this works
//            print(iOData.fetchedObjects?[record] as Any)
//        }
//
//        if let sections = iOData.sections {
//            print(sections.count)
//        }
//        
//        let dataArray = [iOData]
//        
//        for record in dataArray {
//            print(record!)
//        }
//        //print(context.value(forKey: "cVOut") as Any)
//
    }
    
    func attemptFetch () {
        
        let fetchRequest: NSFetchRequest<InOutData> = InOutData.fetchRequest()
        let dateSort = NSSortDescriptor(key: "dateTime", ascending: true)
        fetchRequest.sortDescriptors = [dateSort]
        
        let iOData = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        iOData.delegate = self
        self.iOData = iOData
        
        do {
            
            try iOData.performFetch()
            
        }catch {
            
            let error = error as NSError
            print("\(error)")
            
        }
        
    }

}
