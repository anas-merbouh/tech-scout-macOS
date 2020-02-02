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
    func teamDataSource(_ teamDataSource: TeamDataSource, didFinishLoadingTeamsWithError error: Error) -> Void
    
}

class TeamDataSource: NSObject {
    
    // MARK: - Methods
    
    public weak var delegate: TeamDataSourceDelegate?
    
    /// An array representing the teams participating to the FIRST Robotics
    /// Competition.
    private var _teams: [Team]
    
    // A TeamLoading conforming object representing the object used to retrieve
    // the teams participating to the FIRST Robotics Competition.
    private let teamLoader: TeamLoading
    
    /// An array representing the teams participating to the FIRST Robotics
    /// Competition managed by the data source.
    public var teams: [Team] {
        return _teams
    }

    // MARK: - Initialization
    
    init(teamLoader: TeamLoading) {
        self._teams = []
        self.teamLoader = teamLoader
        
        // Call the super class's implementation of the constructor.
        super.init()
    }
    
    // MARK: - Methods
    
    public func loadTeams() {
        do {
            _teams = try teamLoader.loadTeams()
            delegate?.teamDataSource(self, didFinishLoadingTeams: _teams)
        } catch {
            print("An error occurred while trying to load the data : \(error.localizedDescription)")
        }
    }
    
}

// MARK: - Table view data source
extension TeamDataSource: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return _teams.count
    }
        
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return _teams[row]
    }
    
}

// MARK: - Table view delegate
extension TeamDataSource: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let team = _teams[row]
        var cell: NSTableCellView!
        
        if tableColumn == tableView.tableColumns[0] {
            cell = (tableView.makeView(withIdentifier: TeamNumberTableCellView.reuseIdentifier, owner: nil) as! NSTableCellView)
            cell.textField?.stringValue = "\(team.number)"
            
            // Set the column's title.
            tableColumn?.title = "Team Number"
        } else if tableColumn == tableView.tableColumns[1] {
            cell = (tableView.makeView(withIdentifier: TeamNameTableCellView.reuseIdentifier, owner: nil) as! NSTableCellView)
            cell.textField?.stringValue = team.nickname
        
            // Set the column's title.
            tableColumn?.title = "Team Name"
        } else {
            cell = (tableView.makeView(withIdentifier: TeamLocationTableCellView.reuseIdentifier, owner: nil) as! NSTableCellView)
            cell.textField?.stringValue = team.location
            
            // Set the column's title.
            tableColumn?.title = "Location"
        }
        
        return cell
    }
        
}
