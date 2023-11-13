//
//  DataStructures.swift
//  Tourify
//
//  Created by 顾悦平 on 11/11/23.
//

import Foundation
// Structure: a trip
struct Trip{
    var name: String!
    // TODO: add remaining attributes
    
    //while initializing a new trip, only init its name first. As we move on, we will set remaining variables gradually.
    init(name: String) {
        self.name = name
    }
}

// Sub-structures --> only used for retrieving packed user input
// 1. GeneralInfo page struct
struct GeneralPlan {
    let startDate_: String!
    let endDate_: String!
    let departure_: String!
    let destination_: String!
    let numTravelers_: Int!
}
// 2.


struct Itinerary {
    var budget_: Double!
    var type_ : String!
    var style_ : String!
    var food_ : String!
}

struct Hotel {
    var numRoom_ : Int!
    var rating_ : String!
    var pool_ : Bool!
    var pet_ : Bool!
    var priceRange_ : Double!
}

// Global Variables
// info: update everytime as user input is updated(GeneralInfo page)
var info:GeneralPlan?

// Trips: current stored trips
// To access the trip that is currently being processed, get the last element in the list
var trips:[Trip] = []

