//
//  SideBarDataSource.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-01.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Cocoa

class SideBarDataSource: NSObject {

    public static let applicationSideBarItems: [SideBarItem] = [
        SideBarItem(name: "Data", XIBName: "CompetitionDataViewController"),
        SideBarItem(name: "Teams", XIBName: "TeamListViewController"),
        SideBarItem(name: "Alliance Selection", XIBName: "AllianceSelectionViewController")
    ]
    
    // MARK: - Properties
    
    private let _sideBarItems: [SideBarItem]
    
    /// An array of SideBarItem instances representing the items of the side bar managed by
    /// the data source.
    public var sideBarItems: [SideBarItem] {
        return _sideBarItems
    }
   
    // MARK: Initialization
    
    init(items: [SideBarItem]) {
        self._sideBarItems = items
        
        // Call the super class's implementation of the constructor.
        super.init()
    }
    
}

// MARK: - Outline view data source
extension SideBarDataSource: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return _sideBarItems.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return _sideBarItems[index]
    }
                
}
