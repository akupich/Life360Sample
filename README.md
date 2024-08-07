Introduction
===

This is sample app done in scope of technical task. It allows to build Circles with Life360 members. A Circle refers to a group of members in a shared group. Member locations are shared within a circle. All members of a Circle receive location updates of all other members of the Circle. A member can join multiple Circles.


Structure
---
- **Life360Sample/CircleManagment** contains requested logic by CircleManager Challenge
- **Life360SampleTests** contains few unit tests as example

Requirements
---

- iOS
    - iOS 14+
    - Xcode 12.5.1
    - Swift 5
- macOS
    - Catalina or Big Sur

How to build
---

Please open Life360Sample/Life360Sample.xcodeproj in Xcode.app and press ⌘+U to run tests.


TODO list
---

- Add more tests to cover all of the created functionality
- Add perfomance tests
- Add tests that check thread safety of CircleManager
- Improve func that query Circles by Member count to achive O(1) perfomance
- Improve perfomance of quering all Members with in a given distance of a given location
