//
//  SideBarViewController.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-01.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Cocoa

protocol SideBarViewControllerDelegate: class {
    
    func sideBarViewController(_ sideBarViewController: SideBarViewController, didSelectSideBarItem sideBarItem: SideBarItem) -> Void
    
}

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
        
        // Set the side bar data source's delegate.
        sideBarDataSource.delegate = self
    }
    
    required init?(coder: NSCoder) {
        self.sideBarDataSource = SideBarDataSource(items: SideBarDataSource.applicationSideBarItems)
        
        // Call the super class's implementation of the constructor.
        super.init(coder: coder)
        
        // Set the side bar data source's delegate.
        sideBarDataSource.delegate = self
    }
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
        outlineView.delegate = sideBarDataSource
        outlineView.dataSource = sideBarDataSource
    }
    
}

// MARK: - Side Bar data source
extension SideBarViewController: SideBarDataSourceDelegate {
    
    func sideBarDataSource(_ sideBarDataSource: SideBarDataSource, didSelectSideBarItem sideBarItem: SideBarItem) {
        delegate?.sideBarViewController(self, didSelectSideBarItem: sideBarItem)
    }
    
}
