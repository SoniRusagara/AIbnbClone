---

# AIbnb (SwiftUI, AI Voice Assistant)

A lightweight Airbnb-style iOS app built with SwiftUI. It features Explore/Search/Listing flows with booking and an **AI voice assistant pipeline** (mic → ASR → LLM → TTS). Designed to run locally today and scale into a Firebase-backed product.

**Highlight:** First audio < **400 ms**, p95 < **1.5 s**, > **99%** reliability.

---

## Features

* 🗺️ Explore view, region search, listing detail, booking flow (mock data)
* 🎙️ **AI Voice Assistant** (speech-to-AI-to-speech pipeline)
* 🔐 Sign in with Apple + Keychain (scaffold)
* 🧩 MVVM, Swift Concurrency (async/await, cancellation/backoff)
* 🗃️ (Planned) Firestore for profiles, bookings, preferences
* 🔔 (Planned) Push notifications & TestFlight demo

---

## Tech Stack

* **Language:** Swift (iOS 17)
* **UI:** SwiftUI, MapKit
* **Architecture:** MVVM + Repository pattern
* **AI:** STT/LLM/TTS pipeline (pluggable client)
* **Optional:** Firebase (Auth, Firestore, Storage)
* **Build:** Xcode 15

---

## Getting Started

### Requirements

* Xcode 15
* iOS 17 simulator or device

### Run

```bash
git clone https://github.com/<your-username>/AIbnb.git
cd AIbnb
# Open AIbnb.xcodeproj (or .xcworkspace if you add packages) in Xcode → Run ▶
```

### Info.plist (for voice)

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Mic for voice input</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Transcribe speech to text</string>
```

---

## Notes

* Modular repos let you swap **Local → Firebase** without UI changes.
* Sign in with Apple scaffolded; **Firebase Auth** wiring planned in *Future Work*.

---

## License

MIT (or your preference)

---

## Contact

Created by **Soni Rusagara** — happy to connect!
