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
        self.dataSource = TeamDataSource()
        
        // Call the super class's implementation of the constructor.
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Set the data source's delegate.
        dataSource.delegate = self
    }
    
    required init?(coder: NSCoder) {
        self.dataSource = TeamDataSource()
        
        // Call the super class's implementation of the constructor.
        super.init(coder: coder)
        
        // Set the data source's delegate.
        dataSource.delegate = self
    }
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        dataSource.loadTeams()
    }

}

// MARK: - Team Data Source delegate
extension TeamListViewController: TeamDataSourceDelegate {
    
    func teamDataSource(_ teamDataSource: TeamDataSource, didFinishLoadingTeams loadedTeams: [Team]) {
        tableView.reloadData()
    }
    
    func teamDataSource(_ teamDataSource: TeamDataSource, didFinishLoadingTeamsWithError error: Error) {
        
    }
    
}
