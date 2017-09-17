//
//  DataTableVC.swift
//  Pee Meter Core Data
//
//  Created by Stephen Desterhaft on 12/7/16.
//  Copyright © 2016 Stephen Desterhaft. All rights reserved.
//

import UIKit
import CoreData

class DataTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dateD: UILabel!
    @IBOutlet weak var totalOut: UILabel!
    @IBOutlet weak var totalIn: UILabel!
    @IBOutlet weak var totalCV: UILabel!
    @IBOutlet weak var totalNV: UILabel!
    
    var controller: NSFetchedResultsController<InOutData>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        self.tabBarController?.tabBar.isHidden = false
        
//        generateTestData()
        attemptFetch()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimeCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: TimeCell, indexPath: NSIndexPath) {
        
        var dd: String = ""
        
        let item = controller.object(at: indexPath as IndexPath)
        
        if indexPath.row == 0 {
            dd = (item.value(forKey: "dateTime") as? String)!
            
            captureTopData(dd: dd)
        }

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
        
        return 25
        
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
                let cell = tableView.cellForRow(at: indexPath) as! TimeCell
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
        tableView.deselectRow(at: indexPath, animated: true)
        if let objs = controller.fetchedObjects, objs.count > 0 {
            // might need to change "_" to "item"
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "AddDataVC", sender: item)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddDataVC" {
            if let destination = segue.destination as? AddDataVC {
                if let item = sender as? InOutData {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    func captureTopData(dd: String) {
        
        let ddref = removeTime(dd: dd)
        var cVOutTotal = 0
        var nVOutTotal = 0
        var fInTotal = 0

        let fetchRequest: NSFetchRequest<InOutData> = InOutData.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            //print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
                //print("\(trans.value(forKey: "dateTime")!)")
                let dref = removeTime(dd: trans.value(forKey: "dateTime") as! String)
                if dref == ddref {
                    cVOutTotal += trans.value(forKey: "cVOut") as! Int
                    nVOutTotal += trans.value(forKey: "nVOut") as! Int
                    fInTotal += trans.value(forKey: "fIn") as! Int
                }
                
            }
            
            receiveHeader(dd: dd, cVOutTotal: cVOutTotal, nVOutTotal: nVOutTotal, fInTotal: fInTotal)
            
        } catch {
            print("Error with request: \(error)")
        }
        
        return
    }
    
    func removeTime (dd: String)->String {
        var ddd = dd
        //print(dd)
        let range = ddd.index(ddd.endIndex, offsetBy: -4)..<ddd.endIndex
        ddd.removeSubrange(range)
        
        return ddd
    }
        
        func getContext () -> NSManagedObjectContext {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.persistentContainer.viewContext
        }
    
    func configureHeader(dd: String, cVOutTotal: Int, nVOutTotal: Int, fInTotal: Int) {
        
//        print(dd, cVOutTotal, nVOutTotal, fInTotal)
        
        dateD.text = TimeCell.dateExtractor(dateString: dd)
        let total = cVOutTotal + nVOutTotal
        totalOut.text = String(total)
        totalIn.text = String(fInTotal)
        totalCV.text = String(cVOutTotal)
        totalNV.text = String(nVOutTotal)
        return
    }
    
    func receiveHeader(dd: String, cVOutTotal: Int, nVOutTotal: Int, fInTotal: Int) {
        
        //print(dd, cVOutTotal, nVOutTotal, fInTotal)
        
        configureHeader(dd: dd, cVOutTotal: cVOutTotal, nVOutTotal: nVOutTotal, fInTotal: fInTotal)
        return
        
    }
//    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//    }
//
//    
//    func generateTestData() {
//        
//        let item1 = InOutData(context: context)
//        item1.dateTime = "201612080000"
//        item1.nVOut = 50
//        item1.cVOut = 0
//        item1.fIn = 0
//        
//        let item2 = InOutData(context: context)
//        item2.dateTime = "201612080400"
//        item2.nVOut = 310
//        item2.cVOut = 0
//        item2.fIn = 0
//        
//        let item3 = InOutData(context: context)
//        item3.dateTime = "201612080730"
//        item3.nVOut = 210
//        item3.cVOut = 0
//        item3.fIn = 500
//        
//        let item4 = InOutData(context: context)
//        item4.dateTime = "201612081030"
//        item4.nVOut = 180
//        item4.cVOut = 0
//        item4.fIn = 0
//        
//        let item5 = InOutData(context: context)
//        item5.dateTime = "201612081300"
//        item5.nVOut = 140
//        item5.cVOut = 0
//        item5.fIn = 400
//        
//        ad.saveContext()
//        
//        
//    }
    
    
    
    //func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //let cell = tableView.indexPath.row = 0
        //print(cell.dateTime)
        //captureTopData(dd: cell.dateTime)
//
//        scrollpos
//        tableView(UITableView, cellForRowAt: IndexPath) as! UITableViewCell
//        tableView(tableView: UITableView, cellForRowAt, indexPath: IndexPath) -> UITableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimeCell
//
    //}
    
    

}



