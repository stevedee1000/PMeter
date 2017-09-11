//
//  DataLoggerVC.swift
//  Pee Meter Core Data
//
//  Created by Stephen Desterhaft on 12/9/16.
//  Copyright © 2016 Stephen Desterhaft. All rights reserved.
//

import UIKit

class DataLoggerVC: UIViewController {
    
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    @IBOutlet weak var nVOutLabel: UITextField!
    @IBOutlet weak var cVOutLabel: UITextField!
    @IBOutlet weak var inLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        myDatePicker.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        
        label2.text = "Press Update button above to see data"
        label3.text = "Press Update button above to see data"
        label4.text = "Press Update button above to see data"
        label5.text = "Press Update button above to see data"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateButtonPressed(_ sender: UIBarButtonItem) {
        
        //        label2.isHidden = false
        //        label3.isHidden = false
        //        label4.isHidden = false
        //        label5.isHidden = false
        
        label2.text = DateFormatter.localizedString(from: myDatePicker.date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
        
        let printFormatter = DateFormatter()
        printFormatter.dateFormat = "MMM dd, yyyy, h:mm a"
        
        label2.text = "Date/Time: \(printFormatter.string(from: myDatePicker.date))"
        label3.text = "NV Volume: \(nVOutLabel.text!) mL"
        label4.text = "CV Volume: \(cVOutLabel.text!) mL"
        label5.text = "Drink Volume: \(inLabel.text!) mL"
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmm"
        //_ = formatter.string(from: myDatePicker.date)
        let dataArray = [formatter.string(from: myDatePicker.date), nVOutLabel.text!, cVOutLabel.text!, inLabel.text!]
        label2.text = ""
        label3.text = ""
        label4.text = ""
        label5.text = "dataArray = \(dataArray)"
    }
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

