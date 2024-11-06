# Tasks

1. Refactor `MarketsTableViewController` from MVC into MVVM architecture. Any business logic in the View Model should be unit tested.
2. After completing the first task, what would you choose to do next? In this task we would like to see which would be your next priority and why.
3. If you had more time what would you improve?

----------------------------------------------------------------------------------------


The task involves migrating an existing iOS app from MVC  to MVVM architecture. This shift is aimed at improving modularity, testability, and separation of concerns. Key objectives include:
        * Separation of Concerns: Extracting business logic, including API calls and data processing, from the MarketsTableViewController into a dedicated MarketsViewModel, making the code more maintainable.
        * API Service Layer Extraction: Moving network-related code into a separate MarketService class that handles API interactions and provides clean data to the ViewModel.
        * Concurrency Model Update: Transitioning to Swift's new async/await concurrency model to replace older, callback-based network calls, improving readability and reducing complexity.
        * SwiftUI Integration: Gradually introducing SwiftUI to replace the UIKit views, allowing for reactive, declarative UI updates, while leveraging SwiftUI's state management.

       
# Next Task Priority
After completing the core migration to MVVM, the next priority would focus on:
    1. Gradual Migration to SwiftUI:
        * Task: Incrementally replace UIKit-based views with SwiftUI. Start by converting simpler components, such as cells and lists, to SwiftUI while maintaining backward compatibility with existing UIKit views.
        * Reason: A gradual migration minimises risk while introducing the benefits of SwiftUI’s declarative syntax and modern state management. It also ensures that new features and UI elements are built with future-proof technology.
    2. Refactoring the Network Layer:
        * Task: Refactor the MarketService class by introducing improvements like dependency injection and protocol-based abstraction for network requests. Ensure that all network operations comply with Swift's concurrency model (async/await) and remove callback-based logic.
        * Reason: Refactoring the network layer allows easier unit testing, better separation between services and ViewModels, and full alignment with Swift's concurrency system, leading to more readable, maintainable, and reliable code.
    3. Implement Swift Testing:
        * Task: Write unit tests for both the MarketService and the MarketsViewModel, using Swift's new Testing framework. Implement tests for handling different network scenarios, including errors, empty results, and large datasets.
        * Reason: Testing is critical after the migration to ensure the correctness of the new MVVM architecture and API service layer. Comprehensive test coverage ensures that bugs and regressions are caught early, especially with new Swift concurrency changes.
    4. Ensure Full Concurrency Compliance:
        * Task: Review the entire codebase to ensure that it passes Swift 6’s full concurrency checks. This includes using @MainActor annotations where necessary and ensuring that data races are avoided in asynchronous code.
        * Reason: Swift 6 introduces stricter concurrency checks, helping catch potential issues such as race conditions early during development. Adhering to these checks ensures safer and more robust multi-threaded code.

# If I Had More Time: Future Improvements
    1. Robust Error Handling and User Feedback:
        * Improvement: Improve error handling across the app by providing user-friendly error messages in cases of network failure, data parsing issues, or empty API responses. Additionally, implement retry mechanisms and potential offline modes for better usability.
        * Reason: Enhancing error handling improves user trust and the overall app experience by ensuring users know what’s happening when issues occur.
    2. Local Data Caching & Offline Mode:
        * Improvement: Implement local caching using Core Data, Swift Data or Realm to allow offline access to market data, and reduce redundant network calls.
        * Reason: Caching would provide a better user experience by ensuring data is available even in low or no connectivity scenarios. This would also reduce server load and improve app performance.
    3. Performance Monitoring and Analytics:
        * Improvement: Integrate tools like Firebase Analytics and Crashlytics to monitor app performance, identify bottlenecks, and gather insights into user behaviour.
        * Reason: Analytics provide valuable insights into how users are interacting with the app, and crash reporting ensures issues are caught and fixed before they affect a wider audience.
    4. Optimising UI/UX and Accessibility:
        * Improvement: Enhance the user interface with features like pagination, smooth scrolling, and dynamic text sizing. Additionally, ensure the app meets accessibility standards by supporting VoiceOver and larger text sizes.
        * Reason: Improving UI/UX and ensuring accessibility makes the app more usable and inclusive, attracting a broader audience while improving the overall user experience.

