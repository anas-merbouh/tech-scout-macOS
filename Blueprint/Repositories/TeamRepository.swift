//
//  TeamRepository.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-01-31.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Foundation

class TeamRepository: NSObject {
    
    public enum LoadingError: Error {
        case fileNotFound, invalidContent
    }
    
    // MARK: - Types
    
    private enum FileExtension: String {
        case json = "json"
    }
    
    // MARK: - Methods
    
    public func loadTeams() throws -> [Team] {
        let bundle = Bundle(for: TeamRepository.self)
        
        // Fetch all the teams participating to the FIRST Robotics Competition
        // from the application's bundle.
        guard let teamsDataSetFileURL = bundle.url(forResource: Team.teamDataSetName, withExtension: FileExtension.json.rawValue) else { throw LoadingError.fileNotFound }
                
        // Attempt to read to content of the file located at the given URL.
        guard let teamsData = try? Data(contentsOf: teamsDataSetFileURL, options: .dataReadingMapped) else { throw LoadingError.fileNotFound }
              
        // Attempt to decode the content of the given data as a JSON.
        guard let teamsJSON = try? JSONDecoder().decode([Team].self, from: teamsData) else { throw LoadingError.invalidContent }
        
        return teamsJSON
    }
    
}
