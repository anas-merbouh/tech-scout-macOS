//
//  WindowController.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-01.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Cocoa
import NotificationCenter

protocol WindowToolbarDelegate: class {
    
    /// Notifies the delegate every time the side bar toolbar item is clicked by the user
    ///
    /// - parameter windowToolbar: A NSToolbar representing the toolbar containing the toolbar item clicked by the user.
    /// - parameter sideBarToolbarItem: A NSToolbarItem representing the toolbar item clicked by the user.
    func windowToolbar(_ windowToolbar: NSToolbar, didClickSideBarToolbarItem sideBarToolbarItem: NSToolbarItem) -> Void
    
}

class WindowController: NSWindowController {

    @IBOutlet private weak var toolbar: NSToolbar!

    // MARK: - Properties
    
    public weak var delegate: WindowToolbarDelegate?
    
    // MARK: - Window's lifecycle
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        configureDelegate()
        window?.title = "Tech Scout"
    }
    
    // MARK: - Methods
    
    private func configureDelegate() {
        guard let splitViewController = window?.contentViewController as? SplitViewController else { return }
        
        // Set the SplitViewController instance as the window's controller delegate.
        delegate = splitViewController
    }
    
    @IBAction private func sideBarToolbarItemClicked(_ sender: NSToolbarItem) {
        delegate?.windowToolbar(toolbar, didClickSideBarToolbarItem: sender)
    }
    
}
