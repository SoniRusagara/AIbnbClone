AIbnb (SwiftUI, AI Voice Assistant)

A lightweight Airbnb-style iOS app built with SwiftUI. Includes Explore/Search/Listing flows and an AI voice assistant (mic → ASR → LLM → TTS). Designed to run locally today and grow into a Firebase-backed product.

Highlight: First audio < 400 ms, p95 < 1.5 s; > 99% assistant reliability.

Features

🗺️ Explore, region search, listing detail, booking flow (mock data)
🎙️ AI Voice Assistant: speech-to-AI-to-speech pipeline
🔐 Sign in with Apple + Keychain (scaffold)
🧩 MVVM, Swift Concurrency (async/await, cancellation/backoff)
🗃️ (Planned) Firestore for profiles, bookings, preferences
🔔 (Planned) Push notifications & TestFlight demo

Tech Stack

Language: Swift (iOS 17)
UI: SwiftUI, MapKit
Arch: MVVM, Repository pattern
AI: STT/LLM/TTS pipeline (pluggable client)
Optional: Firebase (Auth, Firestore, Storage)

Build: Xcode 15

Getting Started
Requirements

Xcode 15 (iOS 17 simulator or device)

Run
git clone https://github.com/<your-username>/AIbnb.git
cd AIbnb
# Open AIbnb.xcodeproj (or .xcworkspace if you add packages) in Xcode → Run ▶

Info.plist (for voice)
<key>NSMicrophoneUsageDescription</key>
<string>Mic for voice input</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Transcribe speech to text</string>

License

MIT (or your preference)

Contact

Created by Soni Rusagara — happy to connect!
