//
//  TeamDetailViewController.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-01.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Cocoa

class TeamDetailViewController: NSViewController {

    @IBOutlet private weak var nicknameLabel: NSTextField!
    @IBOutlet private weak var locationLabel: NSTextField!
    
    // MARK: - Properties
    
    private var team: Team?
    
    // MARK: - Initialization
    
    init(team: Team) {
        self.team = team
        
        // Call the super class's implementation of the constructor.
        super.init(nibName: "\(TeamDetailViewController.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.team = nil
        
        // Call the super class's implementation of the constructor.
        super.init(coder: coder)
    }
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
        if let team = self.team {
            populateViews(withTeam: team)
        }
    }
    
    // MARK: - Methods
    
    public func populateViews(withTeam team: Team) {
        nicknameLabel.stringValue = team.nickname
        locationLabel.stringValue = team.location
    }
    
}
