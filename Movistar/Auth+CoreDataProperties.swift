//
//  Auth+CoreDataProperties.swift
//  Movistar
//
//  Created by Frank Travieso on 6/5/16.
//  Copyright © 2016 Wikot. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Auth {

    @NSManaged var id: NSNumber?
    @NSManaged var num: String?
    @NSManaged var ip: String?
    @NSManaged var token: String?
    @NSManaged var typeAuth: String?
    @NSManaged var active: NSNumber?

}
