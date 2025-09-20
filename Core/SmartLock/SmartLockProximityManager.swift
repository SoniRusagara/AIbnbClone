//
//  SmartLockProximityManager.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 9/20/25.
//

import Foundation
import CoreBluetooth

@MainActor
final class SmartLockProximityManager: NSObject, ObservableObject {
  @Published var rssi: Int? = nil
  @Published var isScanning = false

  /// Match peripherals by advertised name (e.g., "DOOR-1234")
  private let targetName = "DOOR"

  private var central: CBCentralManager!

  override init() {
    super.init()
    central = CBCentralManager(delegate: self, queue: nil)
  }

  func start() {
    guard central.state == .poweredOn else { return }
    isScanning = true
    rssi = nil
    central.scanForPeripherals(withServices: nil,
      options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
  }

  func stop() {
    isScanning = false
    central.stopScan()
  }

  // Simple near/far rule (tweak as you like)
  var isNear: Bool {
    guard let v = rssi else { return false }
    return v > -65  // stronger (less negative) = closer
  }
}

extension SmartLockProximityManager: CBCentralManagerDelegate {
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    if central.state == .poweredOn, isScanning { start() }
  }

  func centralManager(_ central: CBCentralManager,
                      didDiscover p: CBPeripheral,
                      advertisementData: [String : Any],
                      rssi RSSI: NSNumber) {
    let name = (advertisementData[CBAdvertisementDataLocalNameKey] as? String)
               ?? p.name ?? ""
    if name.localizedCaseInsensitiveContains(targetName) {
      rssi = RSSI.intValue
    }
  }
}
