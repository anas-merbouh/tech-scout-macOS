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
    
    @IBOutlet private weak var rookieYearLabel: NSTextField!
    @IBOutlet private weak var schoolNameLabel: NSTextField!
    @IBOutlet private weak var teamNumberLabel: NSTextField!
    @IBOutlet private weak var websiteLabel: NSTabView!
    
    @IBOutlet private weak var climbTypeLabel: NSTextField!
    @IBOutlet private weak var intakeTypeLabel: NSTextField!
    @IBOutlet private weak var shooterTypeLabel: NSTextField!
    @IBOutlet weak var drivebaseTypeLabel: NSTextField!
    
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
        teamNumberLabel.stringValue = "\(team.number)"
        schoolNameLabel.stringValue = team.schoolName ?? "No school name associated with the team"
        
        // Populate the rookie year label with the appropriate value.
        if let rookieYear = team.rookieYear {
            rookieYearLabel.stringValue = "\(rookieYear)"
        } else {
            rookieYearLabel.stringValue = "The team does not have any rookie award"
        }
    }
    
}
