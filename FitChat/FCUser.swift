//
//  FCUser.swift
//  
//
//  Created by Farwa Naqi on 2015-08-31.
//
//

import Foundation
import CoreData

class FCUser: NSManagedObject {

    @NSManaged var fullName: String
    @NSManaged var challenges: NSSet

}
