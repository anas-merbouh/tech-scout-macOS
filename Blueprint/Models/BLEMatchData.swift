//
//  BLEMatchData.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-18.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import RealmSwift

struct BLEMatchData: Decodable {

    // MARK: - Types
    
    @objc
    public enum Endgame: Int, Decodable, RealmEnum {
        case climb, park, none
    }
    
    @objc
    public enum Mobility: Int, Decodable, RealmEnum {
        case bad, good, reallyBad, reallyGood
    }
    
    // MARK: - Properties
        
    /// A string representing the name the scouter gave to the match.
    public let name: String
 
    /// A string representing the file name in the local file-system.
    public let fileName: String
    
    /// A string representing the full name of the scouter who collected
    /// the match data.
    public let scouterName: String
    
    /// A string representing the regional during which the match data was collected.
    public let regionalName: String
        
    /// An integer representing the amount of Power Cells
    /// the robot scored in the inner port.
    public let scoredInnerPortCells: Int

    /// An integer representing the amount of Power Cells
    /// the robot scored in the outer port.
    public let scoredOuterPortCells: Int
    
    /// An integer representing the amount of Power Cells
    /// the robot scored in the bottom port.
    public let scoredBottomPortCells: Int

    /// A boolean representing whether or not the robot
    /// climbs at the end of the match.
    public let climbs: Bool
    
    /// A boolean representing whether or not the robot
    /// used the rotation control during the match.
    public let rotationControl: Bool
    
    /// A boolean representing whether or not the robot
    /// used the position control during the match.
    public let positionControl: Bool

    /// A boolean representing whether or not the robot
    /// moves to the initiation line.
    public let movesToInitiationLine: Bool
    
    /// A floating-point number representing the amount of time
    /// it took for the robot to climb, if applicable.
    public let climbDuration: Float?
    
    /// An Endgame enum case representing the action the robot performs
    /// at the end of the match.
    public let endgame: Endgame
    
    /// A Mobility enum case representing the mobility of the robot
    /// during the match.
    public let mobility: Mobility?
    
    /// A string representing additional comments provided
    /// by the scouter.
    public let comments: String?
    
}

