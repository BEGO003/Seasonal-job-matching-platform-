# Sprint 1:
## Story: Profile Creation & Viewing (Mobile)

### 1. Overview:
This user story focuses on enabling users to create and view their personal profiles within the mobile application.
### 2. Features:
-   **Profile Screen Navigation:** Users can access their profile screen from the main application navigation.
-   **View Profile Data:** Display of current user profile information such including:
    -   Full Name
    -   Email Address
    -   Phone Number
    -   Country
-   **Edit Profile Data:** An "Edit Profile" button or similar mechanism to switch the profile view into an editable state.
-   **Feedback Mechanisms:** Visual feedback (e.g., toast messages, loading indicators) for successful profile updates or errors.
-   **Responsive Design:** The profile screen should be responsive and adapt well to various mobile screen sizes and orientations.
### 3. Implementation:
1. Implement state management (e.g., Provider, Riverpod) to handle profile data, form state, and loading states.
2. Implement navigation logic to and from the profile screen.
3. Fetch and Handle User Information using specified API
### 4. Screenshots:
![[2bb1e6a5-3f02-4d1d-a621-c584f778f6da 1.jpeg]]
![[bf8cda2b-cffa-47a5-b372-956962aeb666.jpeg]]
# Sprint 2
## Story: Viewing Job Details
### 1. Overview:
This Story focuses on the core of the app Viewing jobs. so the user can evaluate if it's a good fit for me before I apply.
### 2. Features:
-   **Job Screen Navigation:** Users can access the jobs screen from the main application navigation.
-   **Job Card:** contains basic Job information.
-   **Heart Icon:** the user add the job to Favorites to view later. 
-   **Job View Screen:** after the user presses on a job , a dedicated screen for the job will open viewing all the details about the job with the ability to apply for the job. 
### 3. Implementation:
1.  **State Management:** Implemented `PaginatedJobsNotifier` to handle infinite scrolling, managing page indices and appending new data to the existing state.
2.  **Service Integration:** `JobsServicesProvider` fetches data using `PaginatedJobsResponse` DTO to map backend pagination metadata (total pages, current page).
3.  **UI Architecture:**
    -   `JobCardSection`: Handles the `NotificationListener` for scroll detection and triggers "Load More" actions.
    -   `JobCard`: Features scale animations on tap and visual indicators for "New" or "Closed" jobs.
    -   `JobView`: Details screen built with `CustomScrollView` and `SliverAppBar` for a responsive layout.
4.  **Resilience:** Dedicated widgets for `_LoadingState` (Shimmer), `_ErrorState` (Retry logic), and `_EmptyState`.
3.  **Testing:** 
	1. Loading State: Correctly displays a loading indicator.
	2. Error State: Properly shows an error message when data fetching fails.
	3. Empty State: Shows a user-friendly message when no jobs are available.
	4. Data State: Successfully renders a list of jobs when data is available.
	5. Interaction: Responds to user taps on a job card as intended
	6. Benchmark:
		1. Objective: Quantify **PaginatedJobsProvider** initialization latency across varying scales (1k, 10k, 100k jobs) using a mocked service layer. 
		2. Methodology: Implemented a Stopwatch based performance suite with a **JIT-compiler warm-up** phase to isolate state-mapping execution time. 
		3. Results: **Demonstrated sub-15ms processing for 100,000 items**, confirming high computational scalability and negligible client-side overhead for large datasets.
### 4. Screenshots:
![[a1f3ba5e-d80f-4787-b549-db6698c9843f.jpeg]]
![[a63c663f-f505-4f59-9545-eb4b75f3d571.jpeg]]

# Sprint 3:
## Story: Login/Signup
### 1. Overview:
This story addresses the authentication system, enabling users to create accounts and securely log in. It serves as the gateway to personalized features like profile management and job applications.
### 2. Features:
-   **Authentication Screens:** Dedicated Login and Signup screens with form validation.
-   **Secure API Integration:** Integration with backend authentication endpoints using RESTful standards.
-   **Session Management:** Secure storage of user session tokens and IDs using `AuthStorage`.
-   **Error Handling:** User-friendly error messages for scenarios like invalid credentials, connection timeouts, or server errors.
-   **State persistence:** Automatic management of user login state across app restarts.
### 3. Implementation:
1.  **State Management:** Utilized `AuthNotifier` (Riverpod) to manage authentication states (loading, authenticated, unauthenticated, error).
2.  **Service Layer:** Implemented `AuthService` with `Dio` for handling `POST /login` and `POST /signup` requests.
3.  **Use Cases:** Logic handles optimistic updates and cache invalidation (e.g., clearing profile data) upon logout.
4.  **UI/UX:** Created responsive forms with input validation and feedback loading states.
5.  **Testing:**
    -   **Login UI:** Verified rendering of email and password fields, ensuring "Sign In" button presence.
    -   **Signup UI:** Verified presence of all required registration fields (Name, Country, Phone, Email, Password) and the "Create Account" button.
    -   **Result:** All UI component tests passed successfully.

### 4. Screenshots:
## Story: Apply for a job
### 1. Overview:
This story covers the core functionality of applying for a job position. It allows users to submit their interest along with a personal note/description to the employer.
### 2. Features:
-   **Application Logic:** "Apply" button integration within the Job Detail view.
-   **Validation:** Input validation to ensure a description is provided before submission.
-   **Instant Feedback:** Optimistic UI updates to immediately reflect the "Applied" status while the request processes in the background.
-   **Duplicate Prevention:** Logic to prevent users from applying to the same job multiple times.
### 3. Implementation:
1.  **Clean Architecture:** Implemented `ApplyForJobUseCase` to encapsulate the business logic of submitting an application.
2.  **Optimistic UI:** Used `appliedJobsLocalProvider` to manage a local set of applied job IDs for instant button state updates.
3.  **Controller:** `ApplyController` manages the async flow: validating input, calling the use case, and handling success/error states (e.g., 409 Conflict).
4.  **Repository:** `ApplicationsRepository` handles the network request to the backend API.
5.  **Testing:**
    -   **Apply Button State:** Verified that the button displays "Apply Now" (enabled) when the user has not applied.
    -   **Applied State:** Verified that the button updates to "Applied" (disabled) when the user has already submitted an application.
    -   **Result:** Logic correctly reflects the user's application status from the provider.

### 4. Screenshots:
## Story: My Applications
### 1. Overview:
This story provides a centralized dashboard for users to track the status of their submitted job applications. It offers a timeline view of their application history.
### 2. Features:
-   **Application List:** A scrollable list displaying all job applications submitted by the user.
-   **Visual Status Indicators:** Color-coded status badges (Pending, Approved, Rejected) and icons for quick status recognition.
-   **Timeline Layout:** A visual timeline connecting application cards to represent the user's career journey.
-   **Detail Navigation:** Interactive cards that navigate to a detailed view of the application and job.
-   **Empty & Loading States:** Dedicated UI for loading (skeleton animations) and empty states (when no applications exist).
### 3. Implementation:
1.  **State Management:** `ApplicationsNotifier` watches `personalInformationProvider` to automatically refetch applications when user data changes.
2.  **UI Components:** Developed `_TimelineApplicationCard` for the list items and `_ApplicationsSkeletonLoader` for the loading state.
3.  **Service Integration:** `ApplicationsService` fetches joined data (Application + Job details) for the current user.
4.  **Animations:** Implemented `StaggeredListItem` for smooth entry animations of the list elements.
5.  **Testing:**
    -   **Empty State:** Verified that a "No Applications Yet" message is displayed when the API returns an empty list.
    -   **Data Rendering:** Verified that application cards (with job title and status) are correctly rendered when data is available.
    -   **Result:** Screen handles both empty and populated states correctly.

### 4. Screenshots:


# Sprint 4:
## Story: Matching Engine
### 1. Overview:
This story delivers the core value proposition of the platform: personalized job recommendations. It uses an intelligent matching engine to connect users with jobs that fit their profile and preferences.
### 2. Features:
-   **Recommended Jobs Section:** A dedicated area on the Home Screen displaying top matches.
-   **Dynamic Updates:** Recommendations refresh automatically when the user updates their profile or preferences.
-   **Visual Relevance:** UI highlights why a job is recommended (e.g., "Matches your skills").
### 3. Implementation:
1.  **Provider Logic:** `RecommendedJobsNotifier` orchestrates the data flow. It watches `personalInformationProvider` to trigger a re-fetch whenever the user's profile changes.
2.  **Service Layer:** Integration with `fetchRecommendedJobs` endpoint, passing the user ID to the backend matching algorithm.
3.  **Data Modeling:** Utilized `RecommendedJobsResponse` to parse the specific payload structure returned by the recommendation engine.

### 4. Screenshots:
## Story: Resume and fields and interests
### 1. Overview:
This story empowers users to build a comprehensive professional profile. It goes beyond basic info to capture education, experience, skills, and specific career interests.
### 2. Features:
-   **Resume Management:** A structured form to add/edit Education, Experience, Skills, Languages, and Certificates.
-   **Fields of Interest:** A tagging system for users to specify job categories they are interested in (e.g., "Mobile Development", "Data Science").
-   **Smart Tagging:** Visual feedback for added interests with easy removal options.
-   **Validation:** Form validation to ensure essential details (like dates and institution names) are captured correctly.
### 3. Implementation:
1.  **Resume Screen:** Developed `ResumeScreen` with sections for each resume category using `TextEditingController`s and dynamic list management.
2.  **State Management:** `ResumeNotifier` handles fetching the existing resume and sending updates to the backend. Diffing logic calculates added/removed items to optimize API calls.
3.  **Interests Integration:** Integrated "Fields of Interest" management within the `EditProfileScreen`, allowing users to add tags that directly influence the Matching Engine.
4.  **Testing:**
    -   **Resume Rendering:** Verified that the Resume Screen correctly displays all sections (Experience, Education, Skills, etc.) with the provided data.
    -   **Result:** UI components render data correctly.

### 4. Screenshots:

# Sprint 5:

## Story: Favorite jobs

### 1. Overview:

This story allows users to curate a personal list of jobs they are interested in, providing quick access to saved opportunities for future review or application.

### 2. Features:

-   **Save to Favorites:** Users can toggle the heart icon on any job card to add or remove it from their collection.

-   **Favorites Screen:** A dedicated dashboard displaying all saved jobs.

-   **Stats Header:** Shows the total count of saved jobs.

-   **Resilient Loading:** Implements exponential backoff and retry mechanisms for fetching favorite data, handling partial load failures gracefully.

-   **Animations:** Smooth entry animations for job cards in the favorites list.

### 3. Implementation:

1.  **State Management:** `FavoriteJobsNotifier` manages the collection. It reacts to changes in `personalInformationProvider` (which holds the favorite IDs) to sync the displayed jobs.

2.  **Service Layer:** `FavoritesService` handles batch fetching of job details by their IDs.

3.  **UI/UX:** Developed the `FavoritesScreen` using `CustomScrollView` and slivers for a polished, scrollable experience. Included a `_RetryBanner` for error recovery.

4.  **Testing:**

    -   **Empty State:** Verified that the "No Favorites Yet" message and educational feature cards are displayed when the list is empty.

    -   **Data Rendering:** Verified that saved job cards are correctly rendered with their specific details.

    -   **Result:** UI correctly reflects the user's saved jobs state.



### 4. Screenshots:

## Story: Search of jobs and filters

### 1. Overview:

This story enhances the job exploration experience by providing powerful search and filtering tools, helping users find relevant opportunities quickly within a large dataset.

### 2. Features:

-   **Text Search:** Real-time search by job title or company name.

-   **Category Filters:** Quick-select chips for job types (e.g., Full-time, Part-time).

-   **Advanced Filter Modal:** Bottom sheet for specifying location and minimum salary using a slider.

-   **Active Filter Indicators:** Visual cues (Clear button, colored icons) when filters are applied.

-   **Dynamic Results:** Job list updates instantly as the user types or selects filters.

### 3. Implementation:

1.  **Filter Logic:** `JobsFilterNotifier` maintains the state of all active search parameters (query, type, location, minSalary).

2.  **Search Header:** `JobsSearchHeader` implements the animated search bar and filter chips integration.

3.  **Advanced Modal:** Created `_FilterModal` with a salary slider and location input, utilizing `MaterialPageRoute` alternatives like `showModalBottomSheet`.

4.  **Testing:**

    -   **Search Input:** Verified that typing in the search bar updates the `JobsFilterNotifier` with the correct query.

    -   **Filter Selection:** Verified that selecting a job type chip correctly toggles the filter state.

    -   **Result:** Filter state management behaves predictably across all input types.



### 4. Screenshots:

