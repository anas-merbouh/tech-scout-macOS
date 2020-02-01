//
//  Team.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-01-31.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Foundation

struct Team: Decodable {
    
    public static let teamDataSetName: String = "Teams"
    
    // MARK: - Types
    
    enum CodingKeys: String, CodingKey {
        case name
        case city
        case nickname
        case number = "team_number"
        case province = "state_prov"
        case rookieYear = "rookie_year"
    }
    
    // MARK: - Properties
    
    /// A String representing the name of the team.
    public let name: String
    
    /// A String representing the nickname of the team.
    public let nickname: String
    
    /// An Unsigned Integer representing the unique number of the team
    /// in the FIRST Robotics Compeition..
    public let number: UInt
    
    /// A String representing the city in which the team is based. Optional.
    public let city: String?
    
    /// A String representing the province in which the team is based. Optional.
    public let province: String?
    
    /// An Unsigned Integer representing the year during which the team received
    /// the rookie all-star award. Optional.
    public let rookieYear: UInt?
    
}
