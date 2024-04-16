//
//  Item.swift
//  TripManagement
//
//  Created by suha alrajhi on 07/10/1445 AH.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
