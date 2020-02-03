//
//  SplitViewController.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-01.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
        configureSideBarViewController()
        configureInitialDetailViewController()
    }
    
    // MARK: - Methods
    
    private func configureInitialDetailViewController() {
        let initialViewController = CompetitionDataViewController()
        
        // Create an instance of the initial split view item the controller needs to display.
        let initialSplitViewItem = NSSplitViewItem(viewController: initialViewController)
        
        // Add the created split view item as a split view item of the controller.
        addSplitViewItem(initialSplitViewItem)
    }
    
    private func configureSideBarViewController() {
        guard let sideBarViewController = splitViewItems[0].viewController as? SideBarViewController else { return }
    
        // Set the view controller's delegate.
        sideBarViewController.delegate = self
    }
    
    private func createViewController(forXIBName XIBName: String) -> NSViewController? {
        switch XIBName {
        case "TeamListViewController":
            let teamListViewController = TeamListViewController()
            
            // Set the view controller's delegate
            teamListViewController.delegate = self
            
            return teamListViewController
            
        case "CompetitionDataViewController":
            return CompetitionDataViewController()
            
        case "AllianceSelectionViewController":
            return AllianceSelectionViewController()
            
        default:
            return nil
        }
    }
    
}


// MARK: - Window Toolbar delegate
extension SplitViewController: WindowToolbarDelegate {
    
    func windowToolbar(_ windowToolbar: NSToolbar, didClickSideBarToolbarItem sideBarToolbarItem: NSToolbarItem) {
        let sideBarSplitViewItemAnimator = splitViewItems[0].animator()
        sideBarSplitViewItemAnimator.isCollapsed = !sideBarSplitViewItemAnimator.isCollapsed
    }
    
}

// MARK: - Side Bar View Controller delegate
extension SplitViewController: SideBarViewControllerDelegate {
    
    func sideBarViewController(_ sideBarViewController: SideBarViewController, didSelectSideBarItem sideBarItem: SideBarItem) {
        guard let viewController = self.createViewController(forXIBName: sideBarItem.XIBName) else { return }
        
        // Get the split view item currently displayed by the view controller.
        let currentSplitViewItem = splitViewItems[1]
        
        // Remove the current view controller displayed at the index number of the split views.
        removeSplitViewItem(currentSplitViewItem)
        
        // Create an instance of the split view item the controller needs to display.
        let newSplitViewItem = NSSplitViewItem(viewController: viewController)
        
        // Add the created split view item as a split view item of the controller.
        addSplitViewItem(newSplitViewItem)
    }
    
}

// MARK: - Team List View Controller delegate
extension SplitViewController: TeamListViewControllerDelegate {
    
    private func updateTeamViewController(withTeam team: Team) {
        guard let teamDetailViewController = splitViewItems[2].viewController as? TeamDetailViewController else { return }
    
        // Update the view managed by the view controller.
        teamDetailViewController.populateViews(withTeam: team)
    }
    
    func teamListViewController(_ teamListViewController: TeamListViewController, didDoubleClickTeam doubleClickedTeam: Team) {
        guard splitViewItems.count < 3 else { updateTeamViewController(withTeam: doubleClickedTeam) ; return }
        
        // Get an instance of the Team Detail View Controller and initialize its team property.
        let teamDetailViewController = TeamDetailViewController(team: doubleClickedTeam)
 
        // Create an instance of the split view item the controller needs to display.
        let newSplitViewItem = NSSplitViewItem(viewController: teamDetailViewController)
        
        // Add the created split view item as a split view item of the controller.
        addSplitViewItem(newSplitViewItem)
    }
    
}
