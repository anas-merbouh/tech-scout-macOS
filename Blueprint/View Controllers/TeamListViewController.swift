//
//  TeamListViewController.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-01-31.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Cocoa

class TeamListViewController: NSViewController {
    
    @IBOutlet private weak var tableView: NSTableView!
    
    // MARK: - Properties
    
    private let dataSource: TeamDataSource
    
    // MARK: - Initialization
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        self.dataSource = TeamDataSource(teamLoader: TeamController())
        
        // Call the super class's implementation of the constructor.
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Set the data source's delegate.
        dataSource.delegate = self
    }
    
    required init?(coder: NSCoder) {
        self.dataSource = TeamDataSource(teamLoader: TeamController())
        
        // Call the super class's implementation of the constructor.
        super.init(coder: coder)
        
        // Set the data source's delegate.
        dataSource.delegate = self
    }
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
        dataSource.loadTeams()
    }

    // MARK: - Methods
    
    private func configureTableView() {
        tableView.target = self
        tableView.rowHeight = 40
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.doubleAction = #selector(onTableViewDoubleClick(_:))
    }
    
    @objc
    private func onTableViewDoubleClick(_ sender: AnyObject?) {
        guard tableView.selectedRow >= 0 else { return }
        
        // Get an instance of the selected team.
        let selectedTeam = dataSource.teams[tableView.selectedRow]
    }
    
}

// MARK: - Team Data Source delegate
extension TeamListViewController: TeamDataSourceDelegate {
    
    func teamDataSource(_ teamDataSource: TeamDataSource, didFinishLoadingTeams loadedTeams: [Team]) {
        tableView.reloadData()
    }
    
    func teamDataSource(_ teamDataSource: TeamDataSource, didFinishLoadingTeamsWithError error: Error) {
        print("An error occurred while trying to load the teams : \(error.localizedDescription)")
    }
    
}
