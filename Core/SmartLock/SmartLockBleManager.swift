//
//  SmartLockBleManager.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 9/20/25.
//

import Foundation
import CoreBluetooth

@MainActor
final class SmartLockBleManager: NSObject, ObservableObject {

  struct Device: Identifiable, Equatable {
    let id: UUID
    let peripheral: CBPeripheral
    var name: String
    var rssi: Int
  }

  // GATT UUIDs your simulator will expose
  private let serviceUUID     = CBUUID(string: "FFF0")
  private let powerWriteUUID  = CBUUID(string: "FFF1") // write 0x01/0x00
  private let stateNotifyUUID = CBUUID(string: "FFF2") // notify 0x01/0x00

  @Published var state: CBManagerState = .unknown
  @Published var isScanning = false
  @Published var devices: [Device] = []
  @Published var connectedDevice: Device?
  @Published var canToggle = false
  @Published var deviceOn: Bool?   // nil = unknown

  private var central: CBCentralManager!
  private var peripheral: CBPeripheral?
  private var writeChar: CBCharacteristic?
  private var notifyChar: CBCharacteristic?
  private var reconnectDelay: TimeInterval = 1.0

  override init() {
    super.init()
    central = CBCentralManager(delegate: self, queue: nil)
  }

  func startScan() {
    guard central.state == .poweredOn else { return }
    isScanning = true
    devices.removeAll()
    central.scanForPeripherals(withServices: [serviceUUID],
      options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
  }

  func stopScan() {
    isScanning = false
    central.stopScan()
  }

  func connect(_ d: Device) {
    stopScan()
    reconnectDelay = 1.0
    peripheral = d.peripheral
    peripheral?.delegate = self
    central.connect(d.peripheral, options: nil)
  }

  func disconnect() {
    guard let p = peripheral else { return }
    central.cancelPeripheralConnection(p)
  }

  func setOn(_ on: Bool) {
    guard let p = peripheral, let w = writeChar else { return }
    let data = Data([on ? 0x01 : 0x00])
    let type: CBCharacteristicWriteType =
      w.properties.contains(.write) ? .withResponse : .withoutResponse
    p.writeValue(data, for: w, type: type)
    if notifyChar == nil { deviceOn = on } // optimistic if no notify char
  }
}

extension SmartLockBleManager: CBCentralManagerDelegate {
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    state = central.state
    if state == .poweredOn, isScanning { startScan() }
  }

  func centralManager(_ central: CBCentralManager,
                      didDiscover p: CBPeripheral,
                      advertisementData: [String : Any],
                      rssi RSSI: NSNumber) {
    let id = p.identifier
    let name = (advertisementData[CBAdvertisementDataLocalNameKey] as? String)
               ?? p.name ?? "Unknown"
    if let i = devices.firstIndex(where: { $0.id == id }) {
      devices[i].rssi = RSSI.intValue
      devices[i].name = name
    } else {
      devices.append(Device(id: id, peripheral: p, name: name, rssi: RSSI.intValue))
    }
  }

  func centralManager(_ central: CBCentralManager, didConnect p: CBPeripheral) {
    devices.removeAll(where: { $0.id == p.identifier })
    connectedDevice = Device(id: p.identifier, peripheral: p, name: p.name ?? "Unknown", rssi: 0)
    canToggle = false
    deviceOn = nil
    p.discoverServices([serviceUUID])
  }

  func centralManager(_ central: CBCentralManager,
                      didDisconnectPeripheral p: CBPeripheral, error: Error?) {
    canToggle = false
    connectedDevice = nil
    writeChar = nil
    notifyChar = nil
    deviceOn = nil
    guard let target = self.peripheral, target.identifier == p.identifier else { return }
    // simple backoff auto-reconnect
    Task { @MainActor in
      try? await Task.sleep(nanoseconds: UInt64(reconnectDelay * 1_000_000_000))
      reconnectDelay = min(reconnectDelay * 2, 8)
      central.connect(target, options: nil)
    }
  }
}

extension SmartLockBleManager: CBPeripheralDelegate {
  func peripheral(_ p: CBPeripheral, didDiscoverServices error: Error?) {
    guard error == nil else { return }
    guard let s = p.services?.first(where: { $0.uuid == serviceUUID }) else { return }
    p.discoverCharacteristics([powerWriteUUID, stateNotifyUUID], for: s)
  }

  func peripheral(_ p: CBPeripheral,
                  didDiscoverCharacteristicsFor s: CBService, error: Error?) {
    guard error == nil else { return }
    s.characteristics?.forEach { c in
      if c.uuid == powerWriteUUID { writeChar = c }
      if c.uuid == stateNotifyUUID {
        notifyChar = c
        p.setNotifyValue(true, for: c)
      }
    }
    canToggle = writeChar != nil
  }

  func peripheral(_ p: CBPeripheral, didUpdateValueFor c: CBCharacteristic, error: Error?) {
    guard error == nil, let data = c.value else { return }
    if c.uuid == stateNotifyUUID, let byte = data.first {
      deviceOn = (byte != 0)
    }
  }
}
