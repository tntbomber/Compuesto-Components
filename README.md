# Compuesto-Components

**ComponentHistoryView - SwiftUI Component Service Log Viewer**
  This SwiftUI view displays the service history for a specific component of a bike. It fetches data from a shared UserData object and shows a scrollable list of maintenance events, including service type, data, performed operations, and user comments. The UI adapts to light and dark mode using the environment's color scheme.
**Features:
- Dynamically loads and sorts service events
- Clearly formatted display of service details
- Color-adaptive styling for dark/light themes

**ReplaceComponent - Replace Bike Component Flow**
  This SwiftUI view enables users to replace a specific component on their bike, either with the same model or a different one. Users can input a replacement date, select a reason for replacement, and add optional comments. The UI dynamically adapts based on whether the user opts to reuse the same component or install a new one.
**Features:
- Suppoers both same-part and new-part replacements
- Collects data: replacement date, reason, and user comments
- Integrates with a shared UserData mode for data persistence
- Provides responsive UI design with adaptive color schemes

**MainContentView - Bike Overview Dashboard**
  This is the main dashboard for viewing and selecting bikes in the app. It displays mileage and total usage time for the selected bike, along with a picker to switch between registered bikes. The background image and responsive layout make for a clean and informative summary view.
**Features:
- Displays summary stats for selected bike: distance and time
- Dynamic bike selection via SwiftUI Picker
- Automatically updates default bike selection on change
