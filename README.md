# 📈 021 Trade Assignment – Watchlist (Flutter + BLoC)

## 🎯 Overview

This project is a submission for the **Flutter Developer assignment** provided by 021 Trade.

The task was to implement a **stock watchlist UI** with the ability to **reorder items** using Flutter’s `ReorderableListView`, while following the **BLoC architecture pattern**.

The focus of this implementation is on:
- Clean architecture
- Proper state management using BLoC
- Smooth and responsive UI interactions

---

## 🎥 Demo

<p align="center">
  <img src="https://raw.githubusercontent.com/oneto6/_21tradeasn01/readme/asset/21trade.gif" width="320"/>
</p>

---

## 📱 UI Preview

<p align="center">
  <img src="https://raw.githubusercontent.com/oneto6/_21tradeasn01/readme/asset/21trade.png" width="320"/>
</p>

---

## 🧠 Approach

### 1. Architecture

The project follows a **feature-first architecture** with clear separation of concerns:

* **Presentation Layer** → UI widgets
* **Business Logic Layer** → BLoC
* **Data Layer** → Repository

---

### 2. BLoC Implementation

The watchlist is managed using the BLoC pattern:

* **Events**

  * `WatchlistLoad` → loads initial data
  * `WatchlistReorder` → updates order of stocks

* **States**

  * `WatchlistInit`
  * `WatchlistLoaded`

* **Flow**

  ```
  UI → Event → BLoC → New State → UI rebuild
  ```

---

### 3. Reordering Mechanism

* Implemented using Flutter’s `ReorderableListView`
* UI captures `oldIndex` and `newIndex`
* Event dispatched to BLoC:

```dart
WatchlistReorder(oldIndex, newIndex)
```

* BLoC handles list mutation and emits updated state

---

### 4. Data Handling

* A **mock repository** is used to simulate stock data
* Each stock contains:

  * `id`
  * `name`
  * `price`
  * `change`

---

## 📂 Project Structure

```
lib/
 ├── core/
 │    ├── model/
 │    │    └── stock.dart
 │    └── widgets/
 │         └── stock_tile.dart
 │
 ├── feature/
 │    └── watchlist/
 │         ├── watchlist.dart
 │
 │         ├── bloc/
 │         │    ├── watchlist_bloc.dart
 │         │    ├── watchlist_event.dart
 │         │    └── watchlist_state.dart
 │
 │         ├── repo/
 │         │    └── repo.dart
 │
 │         └── view/
 │              └── watchlist_page.dart
```

---

## 🎨 UI/UX Decisions

* Used **Material 3 theming** with light & dark mode support
* Maintained **typography hierarchy** using `TextTheme`
* Used **colorScheme** for consistent theming
* Ensured:

  * Clean spacing
  * Readable hierarchy
  * Minimal UI distractions

---

## ⚙️ Features

* ✅ Drag & drop reordering
* ✅ BLoC-based state management
* ✅ Light & Dark theme support
* ✅ Clean and reusable UI components
* ✅ Type-safe models

---

## 🚀 How to Run

```bash
git clone https://github.com/oneto6/_21tradeasn01.git
cd _21tradeasn01
flutter pub get
flutter run
```

---

## 🧩 Key Decisions

* Used **BLoC over setState** for scalability
* Kept **business logic inside BLoC**, not UI
* Designed widgets to be **reusable and modular**
* Maintained **feature isolation** for future scalability

---

## 📌 Notes

* The project focuses specifically on the **watchlist reorder mechanism** as per assignment requirements.
* No external APIs are used; data is mocked.

---

## 🙌 Conclusion

This implementation demonstrates:

* Proper use of **Flutter BLoC architecture**
* Clean UI structuring
* Efficient state handling for dynamic lists

---

## 📬 Submission

Repository:
https://github.com/oneto6/_21tradeasn01

---
