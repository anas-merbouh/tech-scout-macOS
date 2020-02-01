//
//  SideBarViewController.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-01.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Cocoa

protocol SideBarViewControllerDelegate: class {
    
    /// Notifies the delegate every time an item of the side menu was clicked by the user.
    ///
    /// - parameter sideBarViewController: A SideBarViewController representing the controller in which the side bar item was clicked.
    /// - parameter sideBarItem: A SideBarItem representing the side bar item selected by the user.
    func sideBarViewController(_ sideBarViewController: SideBarViewController, didSelectSideBarItem sideBarItem: SideBarItem) -> Void
    
}

fileprivate let dataCellIdentifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier("DataCell")

class SideBarViewController: NSViewController {

    @IBOutlet private weak var outlineView: NSOutlineView!
    
    // MARK: - Properties
    
    private let sideBarDataSource: SideBarDataSource
    public weak var delegate: SideBarViewControllerDelegate?
    
    // MARK: - Initialization
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        self.sideBarDataSource = SideBarDataSource(items: SideBarDataSource.applicationSideBarItems)
        
        // Call the super class's implementation of the constructor.
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        self.sideBarDataSource = SideBarDataSource(items: SideBarDataSource.applicationSideBarItems)
        
        // Call the super class's implementation of the constructor.
        super.init(coder: coder)
    }
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
        outlineView.delegate = self
        outlineView.dataSource = sideBarDataSource
    }
    
}

// MARK: - Outline view delegate
extension SideBarViewController: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let view = outlineView.makeView(withIdentifier: dataCellIdentifier, owner: nil) as? NSTableCellView
        
        // Configure the view...
        if let item = item as? SideBarItem {
            view?.textField?.stringValue = item.name
        }
        
        return view
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let outlineView = notification.object as? NSOutlineView else { return }
        
        // Get the Side Bar Item associated with the selected row.
        let selectedSideBarItem = sideBarDataSource.sideBarItems[outlineView.selectedRow]
        
        // Notify the delegate that a side bar item was clicked by the user.
        delegate?.sideBarViewController(self, didSelectSideBarItem: selectedSideBarItem)
    }
    
}
