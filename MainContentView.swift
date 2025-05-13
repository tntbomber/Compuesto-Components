import SwiftUI


struct MainContentView: View {
    @StateObject var userData: UserData

    @State private var selection: String = "home"
    @State private var showModal: Bool = false
    @State var selectedBikeId: String = selectOneLabel
    @State var selectedBike: Bike?
    
    init(userData: UserData) {
        self._userData = StateObject(wrappedValue: userData)
        self._selectedBikeId = State(initialValue: userData.getDefaultBike() ?? selectOneLabel)
        self._selectedBike = State(initialValue: userData.getBike(selectedBikeId))
    }

    var body: some View {        
        VStack {
            Spacer()
            Image(uiImage: UIImage(named: "background.png")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            VStack {
                let miles = userData.getBike(self.selectedBikeId)?.mileage ?? 0
                let time = userData.getBike(self.selectedBikeId)?.time ?? 0
                HStack {
                    Text("Bike Model:")
                    Picker("Select an option", selection: $selectedBikeId) {
                        if selectedBikeId == selectOneLabel {
                            Text(selectOneLabel).tag(selectOneLabel)
                        }
                        ForEach(userData.getBikes(), id: \.id) { bike in
                            Text(bike.name).tag(bike.id)
                        }
                    }
                    .onChange(of: selectedBikeId, perform: {
                        if let bike = UserData.shared.getBike($0) {
                            selectedBike = bike
                            userData.updateDefaultBike(bike.id)
                        }
                        else {
                            self.selectedBikeId = selectOneLabel
                            userData.updateDefaultBike(selectOneLabel)
                        }
                    })
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .font(.system(size: 20))
                .onAppear(perform: {
                    selectedBikeId = userData.getDefaultBike() ?? selectOneLabel
                })
                Text("Distance:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .font(.system(size: 20))
                Text("\(String(format: "%.0f", toDisplayDistance(miles))) \(distanceDisplayUnits())")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                    .font(.system(size: 33))
                Text("Time:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .font(.system(size: 20))
                Text(toDisplayDurationString(time))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .font(.system(size: 33))
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
        }
    }
}

#Preview {
    MainContentView(userData: UserData.shared)
}
