//
//  BLEConnectionController.swift
//  Blueprint
//
//  Created by Anas Merbouh on 2020-02-14.
//  Copyright © 2020 Blueprint Technologies Inc. All rights reserved.
//

import RealmSwift
import CoreBluetooth

class BLEConnectionController: NSObject {
    
    // MARK: - Properties

    private let centralManager: CBCentralManager
    private var scoutingPeripherical: CBPeripheral?
    
    // MARK: - Initialization
    
    init(centralManager: CBCentralManager) {
        self.centralManager = centralManager
        self.scoutingPeripherical = nil
        
        // Call the super class's implementation of the construtor.
        super.init()
        
        // Initialize the central manager's delegate property.
        centralManager.delegate = self
    }
        
}

// MARK: - Central Manager Delegate
extension BLEConnectionController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
            centralManager.scanForPeripherals(withServices: [CBUUID(string: "2c1926aa-086d-4013-9368-050bf6c215d9")])
        default:
            fatalError("Every state should be covered")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        scoutingPeripherical = peripheral
        
        // Initialize the peripheral's delegate property.
        scoutingPeripherical?.delegate = self
        
        // Stop scanning for periphericals.
        central.stopScan()
        
        // Connect to the peripherical.
        central.connect(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("The Macbook has been connected to a peripheral, attempting to discover its services...")
        peripheral.discoverServices(nil)
    }
    
}

// MARK: - Peripheral delegate
extension BLEConnectionController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let matchScoutingService = peripheral.services?.first else { return }
        
        // Display a message on the console each time an advertised servie is discovered.
        print("A service advertised by the peripheral was discovered, attempting to discover its characteristics...")

        peripheral.discoverCharacteristics([CBUUID(string: "1591180d-2737-4bac-8fe9-b93655fbcd4e")], for: matchScoutingService)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        // Display a message on the console each time a characteristic is discovered.
        print("The characteristics of a service were discovered, attempting to read their value...")
        
        characteristics.forEach { peripheral.readValue(for: $0) }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let value = characteristic.value else { return }
        
        // Create a Foundation object from the received data.
        do {
            let jsonDecoder = JSONDecoder()
            let matchData = try jsonDecoder.decode(BLEMatchData.self, from: value)
            
            print(matchData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
