//
//  ChartData+CoreDataProperties.swift
//  Pee Meter Core Data
//
//  Created by Stephen Desterhaft on 9/10/17.
//  Copyright © 2017 Stephen Desterhaft. All rights reserved.
//

import Foundation
import CoreData


extension ChartData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChartData> {
        return NSFetchRequest<ChartData>(entityName: "ChartData")
    }

    @NSManaged public var chartDate: String?
    @NSManaged public var t0000: Double
    @NSManaged public var t0030: Double
    @NSManaged public var t0100: Double
    @NSManaged public var t0130: Double
    @NSManaged public var t0200: Double
    @NSManaged public var t0230: Double
    @NSManaged public var t0300: Double
    @NSManaged public var t0330: Double
    @NSManaged public var t0400: Double
    @NSManaged public var t0430: Double
    @NSManaged public var t0500: Double
    @NSManaged public var t0530: Double
    @NSManaged public var t0600: Double
    @NSManaged public var t0630: Double
    @NSManaged public var t0700: Double
    @NSManaged public var t0730: Double
    @NSManaged public var t0800: Double
    @NSManaged public var t0830: Double
    @NSManaged public var t0900: Double
    @NSManaged public var t0930: Double
    @NSManaged public var t1000: Double
    @NSManaged public var t1030: Double
    @NSManaged public var t1100: Double
    @NSManaged public var t1130: Double
    @NSManaged public var t1200: Double
    @NSManaged public var t1230: Double
    @NSManaged public var t1300: Double
    @NSManaged public var t1330: Double
    @NSManaged public var t1400: Double
    @NSManaged public var t1430: Double
    @NSManaged public var t1500: Double
    @NSManaged public var t1530: Double
    @NSManaged public var t1600: Double
    @NSManaged public var t1630: Double
    @NSManaged public var t1700: Double
    @NSManaged public var t1730: Double
    @NSManaged public var t1800: Double
    @NSManaged public var t1830: Double
    @NSManaged public var t1900: Double
    @NSManaged public var t1930: Double
    @NSManaged public var t2000: Double
    @NSManaged public var t2030: Double
    @NSManaged public var t2100: Double
    @NSManaged public var t2130: Double
    @NSManaged public var t2200: Double
    @NSManaged public var t2230: Double
    @NSManaged public var t2300: Double
    @NSManaged public var t2330: Double
    @NSManaged public var toInOutData: InOutData?

}
