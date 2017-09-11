//
//  InOutData+CoreDataProperties.swift
//  Pee Meter Core Data
//
//  Created by Stephen Desterhaft on 9/10/17.
//  Copyright © 2017 Stephen Desterhaft. All rights reserved.
//

import Foundation
import CoreData


extension InOutData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InOutData> {
        return NSFetchRequest<InOutData>(entityName: "InOutData")
    }

    @NSManaged public var cVOut: Int16
    @NSManaged public var dateTime: String?
    @NSManaged public var fIn: Int16
    @NSManaged public var nVOut: Int16
    @NSManaged public var toChartData: ChartData?

}
