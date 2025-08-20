# 💧 WaterUDrinking? – Hydration Tracking Made Simple

**WaterUDrinking?** is a SwiftUI-powered hydration tracking app built for iOS. With an intuitive calendar view, customizable drink logging, and smooth animations, users can easily track their water intake and stay on top of their hydration goals.

---

## 🛠 Features

* 📆 **Calendar View**
  See your daily drink history at a glance.

* 🧾 **Drink Logging**
  Add, view, and update drink entries with custom volumes.

* 📊 **Hydration Goal Visualization**
  Animated circular progress views to show goal completion (with wave effect).

* 🗃️ **SwiftData Integration**
  All drink data is stored locally using Apple’s SwiftData framework.

* 🛎️ **Custom Notifications**
  Optional reminders to keep you hydrated throughout the day.

* 🔒 **Subscription & One-Time Unlock**
  Access premium features via in-app purchases (StoreKit 2).

---

## 🧱 Architecture

* **SwiftUI**: Declarative UI design.
* **MVVM**: ViewModels for state and logic separation.
* **SwiftData**: Local persistence of drink logs.
* **StoreKit 2**: Handles subscriptions and purchases.
* **Modular Views**:

  * `CalendarView`: Monthly overview with day tap support.
  * `CalendarDrinkList`: Shows drink logs per day.
  * `CupGoalSummaryView`: Goal visualization with animation.
  * `NotificationView` + `NotificationVM`: Manages local notifications.
  * `PurchaseOptionsView`: In-app purchase options UI.

---

## 🧪 Requirements

* iOS 17+
* Xcode 15+
* Swift 5.9+

---

## 💸 In-App Purchases

* 🔓 **One-Time Unlock**: Lifetime access to premium features.
* 🔁 **Monthly Subscription**: Ongoing access with support for future features.
* 🛠 Includes:

  * Add and delete past drink logs
  * Access to all drink menu items
  * Access to all future features and updates

---

## 🔐 Privacy & Terms

* **Terms of Use (EULA)**: [Apple Standard EULA](https://www.apple.com/legal/internet-services/itunes/dev/stdeula/)

---

## 📸 Screenshots

<img src="https://github.com/user-attachments/assets/79b64506-1160-437a-9a3e-ebe26afa4f5a" width="200" />
<img src="https://github.com/user-attachments/assets/01902810-e9fd-4ecf-a978-1f837dc944bf" width="200" />
<img src="https://github.com/user-attachments/assets/660343b8-835d-4f95-911b-1453ec78dee8" width="200" />
<img src="https://github.com/user-attachments/assets/f773974a-78d5-4c01-91d7-c95e58b1669c" width="200" />

---

## 📦 Coming Soon

* 🧊 More drink types and icons
* 🎯 Monthly goal streaks and reports

---

## 🙌 Author

Created by [Gregg Abe](https://github.com/makoto808)

---
