//
//  MainVC.swift
//  Pee Meter Core Data
//
//  Created by Stephen Desterhaft on 12/7/16.
//  Copyright © 2016 Stephen Desterhaft. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<InOutData>!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        generateTestData()
        attemptFetch()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
        
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
        
    }
    
    func attemptFetch () {
        
        let fetchRequest: NSFetchRequest<InOutData> = InOutData.fetchRequest()
        let dateSort = NSSortDescriptor(key: "dateTime", ascending: true)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        //controller.delegate = self
        
        self.controller = controller
        
        do {
            
            try controller.performFetch()
            
        }catch {
            
            let error = error as NSError
            print("\(error)")
        
        }

    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects, objs.count > 0 {
            // might need to change "_" to "item"
            _ = objs[indexPath.row]
        }
    }
    
    
    class func timeExtractor(dateString: String?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyyMMddHHmm"
        let dateString1 = myFormatter.date(from: dateString!)
        let timeString = formatter.string(from: dateString1!)
        return timeString
    }
    
    func generateTestData() {
        
        let item1 = InOutData(context: context)
        item1.dateTime = "201612080000"
        item1.timeTime = MainVC.timeExtractor(dateString: item1.dateTime)
        item1.nVOut = 50
        item1.cVOut = 0
        item1.fIn = 0
        
        let item2 = InOutData(context: context)
        item2.dateTime = "201612080400"
        item2.timeTime = MainVC.timeExtractor(dateString: item2.dateTime)
        item2.nVOut = 310
        item2.cVOut = 0
        item2.fIn = 0
        
        let item3 = InOutData(context: context)
        item3.dateTime = "201612080730"
        item3.timeTime = MainVC.timeExtractor(dateString: item3.dateTime)
        item3.nVOut = 210
        item3.cVOut = 0
        item3.fIn = 500
        
        let item4 = InOutData(context: context)
        item4.dateTime = "201612081030"
        item4.timeTime = MainVC.timeExtractor(dateString: item4.dateTime)
        item4.nVOut = 180
        item4.cVOut = 0
        item4.fIn = 0
        
        let item5 = InOutData(context: context)
        item5.dateTime = "201612081300"
        item5.timeTime = MainVC.timeExtractor(dateString: item5.dateTime)
        item5.nVOut = 140
        item5.cVOut = 0
        item5.fIn = 400
        
        //ad.saveContext()
        
        
    }
    
    @IBAction func inputDataPressed(_ sender: UISegmentedControl) {
        let songTitle = "Quit Playing Games With My Heart"
        if segment.selectedSegmentIndex == 1 {
            performSegue(withIdentifier: "DataLoggerVC", sender: songTitle)
        }
        
    }

}

