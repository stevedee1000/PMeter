//
//  TimeCell.swift
//  Pee Meter Core Data
//
//  Created by Stephen Desterhaft on 12/7/16.
//  Copyright © 2016 Stephen Desterhaft. All rights reserved.
//

import UIKit

class TimeCell: UITableViewCell {
    
    @IBOutlet weak var dateDate: UILabel!
    @IBOutlet weak var timeTime: UILabel!
    @IBOutlet weak var nVOut: UILabel!
    @IBOutlet weak var cVOut: UILabel!
    @IBOutlet weak var fIn: UILabel!
    @IBOutlet weak var dateD: UILabel!
    @IBOutlet weak var totalOut: UILabel!
    @IBOutlet weak var totalIn: UILabel!
    @IBOutlet weak var totalCV: UILabel!
    @IBOutlet weak var totalNV: UILabel!
    
    
    
    
    func configureCell(item: InOutData) {
        
        dateDate.text = TimeCell.dateExtractor(dateString: item.dateTime)
        timeTime.text = TimeCell.timeExtractor(dateString: item.dateTime)
        nVOut.text = String(item.nVOut)
        cVOut.text = String(item.cVOut)
        fIn.text = String(item.fIn)
    }
    
    func configureHeader(dd: String, cVOutTotal: Int, nVOutTotal: Int, fInTotal: Int) {
        
        print(dd, cVOutTotal, nVOutTotal, fInTotal)
        
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
    

    
    class func timeExtractor(dateString: String?) -> String {
        let myFormat = DateFormatter()
        myFormat.dateFormat = "yyyyMMddHHmm"
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "h:mm a"
        let dateString1 = myFormat.date(from: dateString!)
        let timeString = timeFormat.string(from: dateString1!)
        return timeString
    }
    
    class func dateExtractor(dateString: String?) -> String {
        let myFormat = DateFormatter()
        myFormat.dateFormat = "yyyyMMddHHmm"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM dd, yyyy"
        let dateString1 = myFormat.date(from: dateString!)
        let dateString = dateFormat.string(from: dateString1!)
        return dateString
    }

}
