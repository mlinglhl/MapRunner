//
//  Location+CoreDataProperties.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-05-03.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var run: Run?

}
