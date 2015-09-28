//
//  FCChallenge.swift
//  
//
//  Created by Farwa Naqi on 2015-08-31.
//
//

import Foundation
import CoreData

class FCChallenge: NSManagedObject {

    @NSManaged var type: NSNumber
    @NSManaged var players: NSSet

}
