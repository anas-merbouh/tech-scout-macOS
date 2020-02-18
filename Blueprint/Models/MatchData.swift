//
//  MatchData.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-18.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import RealmSwift

class MatchData: Object {

    // MARK: - Properties
           
    /// A string representing the name the scouter gave to the match.
    @objc
    public dynamic var name: String = String()
    
    /// A string representing the file name in the local file-system.
    @objc
    public dynamic var fileName: String = String()
       
    /// A string representing the full name of the scouter who collected
    /// the match data.
    @objc
    public dynamic var scouterName: String = String()
       
    /// A string representing the regional during which the match data was collected.
    @objc
    public dynamic var regionalName: String = String()
           
    /// An integer representing the amount of Power Cells
    /// the robot scored in the inner port.
    @objc
    public dynamic var scoredInnerPortCells: Int = 0

    /// An integer representing the amount of Power Cells
    /// the robot scored in the outer port.
    @objc
    public dynamic var scoredOuterPortCells: Int = 0
       
    /// An integer representing the amount of Power Cells
    /// the robot scored in the bottom port.
    @objc
    public dynamic var scoredBottomPortCells: Int = 0

    /// A boolean representing whether or not the robot
    /// climbs at the end of the match.
    @objc
    public dynamic var climbs: Bool = false
       
    /// A boolean representing whether or not the robot
    /// used the rotation control during the match.
    @objc
    public dynamic var rotationControl: Bool = false
       
    /// A boolean representing whether or not the robot
    /// used the position control during the match.
    @objc
    public dynamic var positionControl: Bool = false

    /// A boolean representing whether or not the robot
    /// moves to the initiation line.
    @objc
    public dynamic var movesToInitiationLine: Bool = false
       
    /// An Endgame enum case representing the action the robot performs
    /// at the end of the match.
    @objc
    public dynamic var endgame: BLEMatchData.Endgame = .none
       
    /// A floating-point number representing the amount of time
    /// it took for the robot to climb, if applicable.
    public var climbDuration: RealmOptional<Float> = RealmOptional<Float>()
    
    /// A Mobility enum case representing the mobility of the robot
    /// during the match.
    public var mobility: RealmOptional<BLEMatchData.Mobility> = RealmOptional<BLEMatchData.Mobility>()
    
    /// A string representing additional comments provided
    /// by the scouter.
    public var comments: String? = nil
    
    // MARK: - Initialization
    
    convenience init(name: String, fileName: String, scouterName: String, regionalName: String, scoredInnerPortCells: Int, scoredOuterPortCells: Int, scoredBottomPortCells: Int, climbs: Bool, rotationControl: Bool, positionControl: Bool, movesToInitiationLine: Bool, climbDuration: Float?, endgame: BLEMatchData.Endgame, mobility: BLEMatchData.Mobility?, comments: String?) {
        self.init()
        
        // Initialize the match data's properties.
        self.name = name
        self.climbs = climbs
        self.endgame = endgame
        self.fileName = fileName
        self.mobility = RealmOptional<BLEMatchData.Mobility>.init(mobility)
        self.comments = comments
        self.scouterName = scouterName
        self.regionalName = regionalName
        self.climbDuration = RealmOptional<Float>(climbDuration)
        self.rotationControl = rotationControl
        self.positionControl = positionControl
        self.scoredInnerPortCells = scoredInnerPortCells
        self.scoredOuterPortCells = scoredOuterPortCells
        self.scoredBottomPortCells = scoredBottomPortCells
        self.movesToInitiationLine = movesToInitiationLine
    }
    
    // MARK: - Helper methods
    
    public static func fromMatchData(_ matchData: BLEMatchData) -> MatchData {
        MatchData(name: matchData.name, fileName: matchData.fileName, scouterName: matchData.scouterName, regionalName: matchData.regionalName, scoredInnerPortCells: matchData.scoredInnerPortCells, scoredOuterPortCells: matchData.scoredOuterPortCells, scoredBottomPortCells: matchData.scoredBottomPortCells, climbs: matchData.climbs, rotationControl: matchData.rotationControl, positionControl: matchData.positionControl, movesToInitiationLine: matchData.movesToInitiationLine, climbDuration: matchData.climbDuration, endgame: matchData.endgame, mobility: matchData.mobility, comments: matchData.comments)
    }
    
}
