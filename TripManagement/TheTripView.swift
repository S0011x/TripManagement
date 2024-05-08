//
//  TheTrip.swift
//  TripManagement
//
//  Created by suha alrajhi on 08/10/1445 AH.
//

import SwiftUI
import CloudKit

struct TheTripView: View {
    var trip: TripsModel?

    var body: some View {
        VStack {
            if let trip = trip {
                Text("Trip Name: \(trip.name)")
                    .font(.largeTitle)
                Text("Trip Code: \(trip.code)")
                    .font(.title)
            } else {
                Text("No trip selected")
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    TheTrip()
        
}

