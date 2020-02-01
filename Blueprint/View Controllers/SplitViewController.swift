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
        configureInitialDetailViewController()
        configureSplitViewItems()
    }
    
    // MARK: - Methods
    
    private func configureInitialDetailViewController() {
        let initialViewController = TeamListViewController()
        
        // Create an instance of the initial split view item the controller needs to display.
        let initialSplitViewItem = NSSplitViewItem(viewController: initialViewController)
        
        // Add the created split view item as a split view item of the controller.
        addSplitViewItem(initialSplitViewItem)
    }
    
    private func configureSplitViewItems() {
        guard let sideBarViewController = splitViewItems[0].viewController as? SideBarViewController else { return }
    
        // Set the view controller's delegate.
        sideBarViewController.delegate = self
    }
    
    // MARK: - Helper methods
    
    private static func viewController(forXIBName XIBName: String) -> NSViewController? {
        switch XIBName {
        case "TeamListViewController":
            return TeamListViewController()
            
        case "CompetitionDataViewController":
            return CompetitionDataViewController()
            
        case "AllianceSelectionViewController":
            return AllianceSelectionViewController()
            
        default:
            return nil
        }
    }
    
}

// MARK: - Side Bar View Controller delegate
extension SplitViewController: SideBarViewControllerDelegate {
    
    func sideBarViewController(_ sideBarViewController: SideBarViewController, didSelectSideBarItem sideBarItem: SideBarItem) {
        guard let viewController = SplitViewController.viewController(forXIBName: sideBarItem.XIBName) else { return }
        
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
