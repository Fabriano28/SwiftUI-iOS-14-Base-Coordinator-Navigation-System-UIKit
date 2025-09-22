# Project Architecture Guide

This document provides a high-level overview of the project's structure and the core architectural patterns used. The goal is to create a system that is modular, scalable, and easy to maintain.

---

## 🏛️ Core Architectural Patterns

The architecture is built on a few key patterns that work together to create a clear separation of concerns.

* **State-Driven App Flow**
    * The **`AppStateManager`** is the single source of truth for the app's global state (e.g., `.unauthenticated`, `.authenticated`).
    * The root **`AppCoordinator`** observes this state and is responsible for presenting the correct feature flow (e.g., showing the `AuthenticationCoordinator` or the `DashboardCoordinator`).

* **Hierarchical Coordinator Pattern**
    * **Coordinators** are objects that manage navigation logic for a specific user flow. They are the only objects that know how to create and present views.
    * This pattern is hierarchical. A parent coordinator (like `DashboardCoordinator`) can manage and present child coordinators (like `HomeCoordinator` or `ProfileCoordinator`), each responsible for a sub-flow.

* **Factory-per-Feature (Dependency Injection)**
    * A **Factory** is an object responsible for creating a view and injecting all of its dependencies (like ViewModels and UseCases).
    * Each feature (e.g., `Login`, `Home`, `Profile`) has its own dedicated Factory.
    * A top-level **`AppFactory`** acts as the composition root, creating and holding instances of all the feature-specific factories. This keeps dependency management clean and centralized.

* **MVVM + Use Cases**
    * The app follows a clear data flow:
        1.  **View**: The UI layer; it's simple and only communicates with the ViewModel.
        2.  **ViewModel**: Manages the state for the View and contains presentation logic.
        3.  **UseCase**: Encapsulates a single piece of business logic (e.g., `GetUserProfileUseCase`). It's called by the ViewModel.
        4.  **Repository**: The data layer, responsible for fetching data from a remote or local source.

---

## 📁 Folder Structure Overview

The project is organized into modules to enforce separation and make the codebase easier to navigate.

* **`LearningApp/`**
    * The main application target. This is the **Composition Root** where the `AppFactory`, `AppStateManager`, and `AppCoordinator` are initialized.

* **`Features/`**
    * Contains all the user-facing features, with each feature in its own subfolder (e.g., `Authenticated`, `Unauthenticated`).
    * **`Features/{FeatureName}/DI/`**: Contains the `Factory` for that feature.
    * **`Features/{FeatureName}/Domain/`**: Contains the `UseCases` for that feature.
    * **`Features/{FeatureName}/Navigation/`**: Contains the `Coordinator` for that feature.
    * **`Features/{FeatureName}/Presentation/`**: Contains the `Views` and `ViewModels`.

* **`Navigation/`**
    * Contains the reusable, feature-agnostic navigation components like the base `Coordinator` protocol, the `Router`, and the `NavigationControllerHost`.

* **`Network/`**
    * The data layer, containing `Repository` implementations that handle API communication.

* **`Core/`, `CoreEntity/`, `CommonUI/`**
    * These are foundational modules for shared code, data models (DTOs), and reusable UI components, respectively. They have no dependencies on any feature modules.