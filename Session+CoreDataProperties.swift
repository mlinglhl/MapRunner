//
//  Session+CoreDataProperties.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-05-03.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var steps: Int16
    @NSManaged public var runs: NSOrderedSet?

}

// MARK: Generated accessors for runs
extension Session {

    @objc(insertObject:inRunsAtIndex:)
    @NSManaged public func insertIntoRuns(_ value: Run, at idx: Int)

    @objc(removeObjectFromRunsAtIndex:)
    @NSManaged public func removeFromRuns(at idx: Int)

    @objc(insertRuns:atIndexes:)
    @NSManaged public func insertIntoRuns(_ values: [Run], at indexes: NSIndexSet)

    @objc(removeRunsAtIndexes:)
    @NSManaged public func removeFromRuns(at indexes: NSIndexSet)

    @objc(replaceObjectInRunsAtIndex:withObject:)
    @NSManaged public func replaceRuns(at idx: Int, with value: Run)

    @objc(replaceRunsAtIndexes:withRuns:)
    @NSManaged public func replaceRuns(at indexes: NSIndexSet, with values: [Run])

    @objc(addRunsObject:)
    @NSManaged public func addToRuns(_ value: Run)

    @objc(removeRunsObject:)
    @NSManaged public func removeFromRuns(_ value: Run)

    @objc(addRuns:)
    @NSManaged public func addToRuns(_ values: NSOrderedSet)

    @objc(removeRuns:)
    @NSManaged public func removeFromRuns(_ values: NSOrderedSet)

}
