# **Marvel Comics App**

This repository serves as a demonstration of skills in iOS app development, showcasing modern architectural patterns, testing strategies, and external library integration. The app fetches and displays Marvel characters, their associated comics, and a comic list.

---

## **Architecture Overview**

The project is built using the **MVVM-C (Model-View-ViewModel-Coordinator)** pattern, which ensures a clean separation of concerns, facilitates testing, and enhances scalability.

### **High-Level Architecture**
- **Model:** Handles raw data and entities retrieved from the API.
- **View:** Composed of `UIView` and `UIViewController` to manage UI components. Displays data provided by the ViewModel.
- **ViewModel:** Acts as a bridge between the View and Model layers, providing formatted data and handling user interactions.
- **Coordinator:** Manages navigation and flow control across the app, ensuring smooth transitions between views.

---

## **Modules Overview**

The app is structured into multiple modules, ensuring better separation of concerns and maintainability. The flow of the app is as follows:

1. **Splash Screen:** The initial screen that loads when the app starts.
2. **Home Screen:** Displays two main tabs:
   - **Comics Tab:** A collection view displaying a grid of available comics.
   - **Characters Tab:** A list view with endless pagination to fetch and display characters.
3. **Character Details:** Clicking on a character navigates to a **SwiftUI-powered detail screen** with a sticky header design.
4. **Sharing Feature:** Users can share character details from the detail screen.

---

## **External Libraries**

The project uses the following external libraries:

- **Kingfisher:** For handling image downloading and caching.
- **SnapshotTesting:** For UI snapshot testing to ensure UI consistency across device configurations.

These libraries are added using **Swift Package Manager**.

---

## **Setup**

1. Clone this repository.
2. Install dependencies via Swift Package Manager.
3. Run the app in Xcode.

---

## **Missing Features / Under Construction**

- **Character Details and Comics:** These sections are still under construction. The logic to fetch and display detailed character information and associated comics is in progress.
- **Unit Tests:** Additional unit tests are needed for services and view models. Currently, the focus is on UI testing and integration.
- **UI Components:** Some parts of the UI are still missing or need refinement.

---

## **To-Do / Future Enhancements**

- Implement more unit tests to validate the business logic.
- Finalize character details.
- Add empty states for features.
- Improve UI elements and refine missing UI components.

---

## **License**

This project uses the Marvel API, which is a publicly available API provided by Marvel. Please note that this project is not affiliated with, endorsed by, or in any way officially connected to Marvel Entertainment, LLC. The use of the Marvel API is governed by its own terms of service, which can be found on their website.

This project is not licensed under any formal open-source license. You may use it for personal and educational purposes. Commercial use, redistribution, and modification are not permitted without prior consent.

---

# **Disclaimer**

This project is open-source and freely available for use in any capacity. Please be aware that the author is not responsible for any issues or consequences that may arise from its usage in production applications or any other type of project. Use this project at your own discretion and risk.