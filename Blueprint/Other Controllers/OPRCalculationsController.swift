//
//  OPRCalculationsController.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-09.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import Metal
import MetalPerformanceShaders

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
        guard let commandQueue = device.makeCommandQueue(),
              let commandBuffer = commandQueue.makeCommandBuffer() else { return }
        
        // Create a MPSMatrixMultiplication instance representing the multiplication kernel
        // sent to the GPU.
        let mmKernel = MPSMatrixMultiplication(device: device,
                                transposeLeft: false,
                                transposeRight: false,
                                resultRows: 4,
                                resultColumns: 1,
                                interiorColumns: 4,
                                alpha: 1,
                                beta: 0)
        
        // Create the appropriate entries.
        let scoresMatrixEntries: [Float32] = [28, 53, 48, 68]
        let allianceMatrixEntries: [Float32] = [
            1, 1, 1, 0,
            1, 0, 1, 1,
            1, 1, 0, 1,
            0, 1, 1, 1
        ]
        
        // Compute the amount of bytes taken by each matrix's entries.
        let scoresMatrixEntriesSize = MemoryLayout<Float32>.stride * scoresMatrixEntries.count
        let allianceMatrixEntriesSize = MemoryLayout<Float32>.stride * allianceMatrixEntries.count
        
        // Create the appropriate buffers.
        guard let scoresBuffer = device.makeBuffer(bytes: scoresMatrixEntries, length: scoresMatrixEntriesSize, options: .storageModeShared),
            let allianceBuffer = device.makeBuffer(bytes: allianceMatrixEntries, length: allianceMatrixEntriesSize, options: .storageModeShared)
        else { return }
        
        // Create the appropriate descriptors.
        let scoresMatrixDescriptor = MPSMatrixDescriptor(rows: 4, columns: 1, rowBytes: scoresMatrixEntriesSize / 4, dataType: .float32)
        let allianceMatrixDescriptor = MPSMatrixDescriptor(rows: 4, columns: 4, rowBytes: allianceMatrixEntriesSize / 4, dataType: .float32)
        
        // Create the appropriate MPSMatrix instances.
        let scoresMatrix = MPSMatrix(buffer: scoresBuffer, descriptor: scoresMatrixDescriptor)
        let allianceMatrix = MPSMatrix(buffer: allianceBuffer, descriptor: allianceMatrixDescriptor)
        
        let resultMatrixEntriesSize = MemoryLayout<Float32>.stride * allianceMatrix.rows * scoresMatrix.columns
        let resultMatrixDescriptor = MPSMatrixDescriptor(rows: allianceMatrix.rows, columns: scoresMatrix.columns, rowBytes: resultMatrixEntriesSize / allianceMatrix.rows, dataType: .float32)
        
        guard let multiplicationResultBuffer = device.makeBuffer(length: resultMatrixEntriesSize, options: .storageModeShared) else { return }
        
        let multiplicationResultMatrix = MPSMatrix(buffer: multiplicationResultBuffer, descriptor: resultMatrixDescriptor)
        
        // Encode the multiplication kernel.
        mmKernel.encode(commandBuffer: commandBuffer, leftMatrix: allianceMatrix, rightMatrix: scoresMatrix, resultMatrix: multiplicationResultMatrix)
        
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
        
        var output = [Float32]()
        let rawPointer = multiplicationResultMatrix.data.contents()
        let typePointer = rawPointer.bindMemory(to: Float32.self, capacity: allianceMatrix.rows * scoresMatrix.columns)
        let bufferPointer = UnsafeBufferPointer(start: typePointer, count: allianceMatrix.rows * scoresMatrix.columns)
   
        bufferPointer.map { value in
            output += [value]
        }
    
        for i in 1...output.count {
            if i % multiplicationResultMatrix.rows == 0 {
                print(output[i-1], terminator: "\n\n")
            } else {
                print(output[i-1], terminator: " ")
            }
        }
    }
    
}
