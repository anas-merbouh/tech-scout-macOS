//
//  MatchRepository.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-18.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import RealmSwift

protocol MatchDataPersisentStore {
    
    /// Persits the given BLEMatchData instance into the device's local storage.
    ///
    /// - parameter matchData: The match data instance to persist.
    func saveMatchData(_ matchData: BLEMatchData) throws -> Void
    
}

struct MatchDataRepository {
    
    // MARK: - Properties
    
    private let database: Realm
    
    // MARK: - Initialization
    
    init(database: Realm) {
        self.database = database
    }
    
}

// MARK: - Match Data Persistent Store
extension MatchDataRepository: MatchDataPersisentStore {
    
    func saveMatchData(_ matchData: BLEMatchData) throws -> Void {
        try database.write { database.add(MatchData.fromMatchData(matchData), update: .error) }
    }
    
}
