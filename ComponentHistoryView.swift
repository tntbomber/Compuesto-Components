import SwiftUI

struct ComponentHistoryView: View {
    @Environment(\.colorScheme) var colorScheme

    @StateObject var userData = UserData.shared

    let bikeId: String
    let componentName: String

    var body: some View {
        let foreground = colorScheme == .dark ? Color.white : Color.black

        let events = userData.getServiceEventsForComponent(bikeId: bikeId, componentName: componentName).sorted {$0.serviceDate > $1.serviceDate}

        ScrollView {
            ForEach(events) { event in
                Divider()
                VStack {
                    HStack {
                        Text("Service Type").bold()
                            .foregroundColor(foreground)

                        Text(event.eventType.rawValue)
                            .foregroundColor(foreground)

                    }
                    HStack {
                        Text("Event Date").bold()
                            .foregroundColor(foreground)

                        Text(event.serviceDate.formatted(date: .abbreviated, time: .omitted))
                            .foregroundColor(foreground)

                    }
                    HStack {
                        Text("Operations").bold()
                            .foregroundColor(foreground)

                        let operationStrings = event.maintenanceOperations.map { $0.rawValue }
                        Text(operationStrings.joined(separator: ","))
                            .foregroundColor(foreground)

                    }
                    
                    HStack {
                        Text("Comments").bold()
                            .foregroundColor(foreground)

                        Text(event.comments)
                            .foregroundColor(foreground)

                    }
                }
            }
        }
    }
}

#Preview {
    ComponentHistoryView(bikeId: "1", componentName: "2")
}
