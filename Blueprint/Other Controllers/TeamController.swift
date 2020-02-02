//
//  TeamController.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-01.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Cocoa

protocol TeamLoading {
    
    /// Loads all teahs teams competing in the FIRST Robotics Competition
    func loadTeams() throws -> [Team]
    
}

class TeamController: NSObject {

    public enum LoadingError: Error {
        case fileNotFound, invalidContent
    }
    
    // MARK: - Types
    
    private enum FileExtension: String {
        case json = "json"
    }
    
    // MARK: - Properties
    
    private let bundle: Bundle
    
    // MARK: - Initialization
    
    override init() {
        self.bundle = Bundle(for: TeamController.self)
        
        // Call the super class's implementation of the constructor.
        super.init()
    }
        
}

// MARK: - Team Loading
extension TeamController: TeamLoading {
    
    public func loadTeams() throws -> [Team] {
        guard let teamsDataSetFileURL = bundle.url(forResource: Team.teamDataSetName, withExtension: FileExtension.json.rawValue) else { throw LoadingError.fileNotFound }
                
        // Attempt to read to content of the file located at the given URL.
        guard let teamsData = try? Data(contentsOf: teamsDataSetFileURL, options: .dataReadingMapped) else { throw LoadingError.fileNotFound }
              
        // Attempt to decode the content of the given data as a JSON.
        guard let teamsJSON = try? JSONDecoder().decode([Team].self, from: teamsData) else { throw LoadingError.invalidContent }
        
        return teamsJSON
    }
    
}
