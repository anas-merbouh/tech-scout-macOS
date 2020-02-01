//
//  TeamDataSource.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-01-31.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Cocoa

protocol TeamDataSourceDelegate: class {
    
    func teamDataSource(_ teamDataSource: TeamDataSource, didFinishLoadingTeams loadedTeams: [Team]) -> Void
    
}

class TeamDataSource: NSObject {
    
    // MARK: - Methods
    
    public weak var delegate: TeamDataSourceDelegate?
    
    /// An array representing the teams participating to the FIRST Robotics
    /// Competition.
    private var teams: [Team]
    
    // A TeamRepository representing the object used to retrieve
    // the teams participating to the FIRST Robotics Competition.
    private let teamRepository: TeamRepository

    // MARK: - Initialization
    
    override init() {
        self.teams = []
        self.teamRepository = TeamRepository()
        
        // Call the super class's implementation of the constructor.
        super.init()
    }
    
    // MARK: - Methods
    
    public func loadTeams() {
        do {
            teams = try teamRepository.loadTeams()
            delegate?.teamDataSource(self, didFinishLoadingTeams: teams)
        } catch {
            print("An error occurred while trying to load the data : \(error.localizedDescription)")
        }
    }
    
}

// MARK: - Table view data source
extension TeamDataSource: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return teams[row]
    }
    
}

// MARK: - Table view delegate
extension TeamDataSource: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard tableColumn == tableView.tableColumns[0] else { return nil }
        guard let cell = tableView.makeView(withIdentifier: TeamNameTableCellView.reuseIdentifier, owner: nil) as? NSTableCellView else { return nil }
        
        // Configure the cell...
        let team = teams[row]
        cell.textField?.stringValue = team.name
        
        return cell
    }
    
}
