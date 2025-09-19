//
//  AssistantView.swift
//  AirbnbClone
//
//  Created by Soni Rusagara on 9/16/25.
//

import SwiftUI
import SiriWaveView

struct AssistantView: View {
    @State var vm = AssistantModel()
    @State var isSymbolAnimating = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("AIbnb Voice Assistant")
                .font(.title2)
            
            Spacer()
            
            // Live waveform driven by current audio power
            SiriWaveView(power: $vm.audioPower)
                .opacity(vm.siriWaveFormOpacity)
                .frame(height: 256)
                .overlay { overlayView } // state-dependent overlay
            
            Spacer()
            
            // Primary action area switches by state
            switch vm.state {
            case .recordingSpeech:
                cancelRecordingButton
                
            case .processingSpeech, .playingSpeech:
                cancelButton
                
            default: EmptyView()
            }

            // Voice picker (disabled unless idle so it doesn’t change mid-turn)
            Picker("Select Voice", selection:
                    $vm.selectedVoice) {
                ForEach(VoiceType.allCases, id:
                            \.self) {
                    Text($0.rawValue).id($0)
                }
            }
            .pickerStyle(.segmented)
            .disabled(!vm.isIdle)
            
            if case let .error(error) = vm.state {
                Text(error.localizedDescription)
                    .foregroundStyle(.red)
                    .font(.caption)
                    .lineLimit(2)
            }
        }
        .padding()

    }
    
    // Overlay on the waveform area changes with state
    @ViewBuilder
    var overlayView: some View {
        switch vm.state {
        case .idle, .error:
            startCaptureButton
        case .processingSpeech:
            // Fun “thinking” icon; could theme for travel later
            Image(systemName: "brain") //todo: maybe change to like an airplane for traveling theme
                .symbolEffect(.bounce.up.byLayer,
                              options: .repeating, value: isSymbolAnimating)
                .font(.system(size: 128))
                .onAppear { isSymbolAnimating = true }
                .onDisappear { isSymbolAnimating = false }
        default: EmptyView()
        }
    }
    
    // Big mic to kick off capture audio → VM orchestrates recording/transcribe/LLM/TTS
    var startCaptureButton: some View {
        Button {
            vm.startCaptureAudio()
        } label: {
            Image(systemName: "mic.circle")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 128))
        }.buttonStyle(.borderless)
        
    }
    
    // Cancel only the recording phase
    var cancelRecordingButton: some View {
        Button(role: .destructive){
            vm.cancelRecording()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 44))
        }.buttonStyle(.borderless)
    }
    
    var cancelButton: some View {
        Button(role: .destructive){
            vm.cancelProcessingTask()
        } label: {
            Image(systemName: "stop.circle.fill")
                .symbolRenderingMode(.monochrome)
                .foregroundStyle(.red)
                .font(.system(size: 44))
            
        }.buttonStyle(.borderless)
    }
        
}



#Preview("Idle") {
    ContentView()
}

#Preview("Recording Speech") {
    let vm = AssistantModel()
    vm.state = .recordingSpeech
    vm.audioPower = 0.2
    return AssistantView(vm: vm)
}

#Preview("Processing Speech") {
    let vm = AssistantModel()
    vm.state = .processingSpeech
    return AssistantView(vm: vm)
}

#Preview("Playing Speech") {
    let vm = AssistantModel()
    vm.state = .playingSpeech
    vm.audioPower = 0.3
    return AssistantView(vm: vm)
}

#Preview("Error") {
    let vm = AssistantModel()
    vm.state = .error("An error has occurred")
    return AssistantView(vm: vm)
}
