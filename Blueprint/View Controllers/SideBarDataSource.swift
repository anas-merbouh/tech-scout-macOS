//
//  SideBarDataSource.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-01.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Cocoa

fileprivate let dataCellIdentifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier("DataCell")

protocol SideBarDataSourceDelegate: class {
    
    func sideBarDataSource(_ sideBarDataSource: SideBarDataSource, didSelectSideBarItem sideBarItem: SideBarItem) -> Void
    
}

class SideBarDataSource: NSObject {

    public static let applicationSideBarItems: [SideBarItem] = [
        SideBarItem(name: "Data"),
        SideBarItem(name: "Teams"),
        SideBarItem(name: "Alliance Selection")
    ]
    
    // MARK: - Properties
    
    private let sideBarItems: [SideBarItem]
    public weak var delegate: SideBarDataSourceDelegate?
    
    // MARK: Initialization
    
    init(items: [SideBarItem]) {
        self.sideBarItems = items
        
        // Call the super class's implementation of the constructor.
        super.init()
    }
    
}

// MARK: - Outline view data source
extension SideBarDataSource: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return sideBarItems.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return sideBarItems[index]
    }
                
}

// MARK: - Outline view delegate
extension SideBarDataSource: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let view = outlineView.makeView(withIdentifier: dataCellIdentifier, owner: nil) as? NSTableCellView
        
        // Configure the view...
        if let item = item as? SideBarItem {
            view?.textField?.stringValue = item.name
        }
        
        return view
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        delegate?.sideBarDataSource(self, didSelectSideBarItem: SideBarItem(name: "Data"))
    }
    
}
