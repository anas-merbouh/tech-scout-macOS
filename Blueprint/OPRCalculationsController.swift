//
//  OPRCalculationsController.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-09.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Metal

class OPRCalculationsController: NSObject {
    
    // MARK: - Properties
    
    private let device: MTLDevice
    private var computeTeamOPRFunctionPSO: MTLComputePipelineState?
    
    // MARK: - Initialization
    
    init(device: MTLDevice) {
        self.device = device
        
        // Call the super class's implementation of the constructor.
        super.init()
    }
    
    // MARK: - Methods
    
    private func loadShaderFiles() {
        guard let library = device.makeDefaultLibrary() else { print("The default Metal library could not be found.") ; return }
        guard let computeOPRFunction = library.makeFunction(name: "compute_team_opr") else { print("Failed to find the function to calculate a team's OPR."); return }
        
        // Attempt to create a Metal Compute pipeline.
        do {
            computeTeamOPRFunctionPSO = try device.makeComputePipelineState(function: computeOPRFunction)
        } catch {
            print("An error occurred while trying to create the Metal Compute Pipeline : \(error.localizedDescription)")
        }
        
        // Configure the command queue used to send work to the GPU.
        configureCommandeQueue()
    }
    
    private func configureCommandeQueue() {
        guard let commandQueue = device.makeCommandQueue() else { return }
    }
    
}
