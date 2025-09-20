//
//  SmartLockCard.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 9/20/25.
//

import SwiftUI

struct SmartLockCard: View {
  @StateObject private var proximity = SmartLockProximityManager()
  @StateObject private var lock = SmartLockBleManager()

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Connect to Home").font(.headline)

      // Proximity (scan-only)
      HStack {
        Circle()
          .fill(proximity.isNear ? .green.opacity(0.9) : .gray.opacity(0.3))
          .frame(width: 12, height: 12)
        Text(proximity.isNear ? "You’re at the door" : "Go closer to the door")
          .foregroundStyle(.secondary)
        Spacer()
        Button(proximity.isScanning ? "Stop" : "Start") {
          proximity.isScanning ? proximity.stop() : proximity.start()
        }
        .buttonStyle(.bordered)
      }

      if proximity.isNear {
        Divider().padding(.vertical, 2)

        if let connected = lock.connectedDevice {
          // Connected → show toggle
          HStack {
            Text("Connected: \(connected.name)").font(.subheadline)
            Spacer()
            Button("Disconnect") { lock.disconnect() }
              .buttonStyle(.bordered)
          }

          Toggle("Door Unlock", isOn: Binding(
            get: { lock.deviceOn ?? false },
            set: { lock.setOn($0) }
          ))
          .disabled(!lock.canToggle)

        } else {
          // Not connected yet
          HStack {
            Button(lock.isScanning ? "Stop Scan" : "Scan Devices") {
              lock.isScanning ? lock.stopScan() : lock.startScan()
            }
            .buttonStyle(.borderedProminent)
            Spacer()
          }
          ForEach(lock.devices.prefix(3)) { d in
            HStack {
              Text(d.name).lineLimit(1)
              Spacer()
              Button("Connect") { lock.connect(d) }
                .buttonStyle(.bordered)
            }
          }
        }
      }
    }
    .padding()
    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
    .onAppear {
      // Optional: auto-start proximity scan
      if !proximity.isScanning { proximity.start() }
    }
  }
}
