import SwiftUI

enum ReplacementReason: String, CaseIterable {
    case wornOut = "Worn Out"
    case damaged = "Damaged"
    case other = "Other"
    case none = "None"
}

struct ReplaceComponent: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var userData = UserData.shared
    @Environment(\.dismiss) var dismiss
    
    @State var bikeId: String
    @State var component: Component
    @State var replaceWithExisting = true
    @State var replacementDate = Date()
    @State var replacementReason: String?
    @State var comments: String = ""
    
    var body: some View {
        let foreground = colorScheme == .dark ? Color.white : Color.black
        
        Spacer().frame(height: 20)
        HStack {
            Spacer().frame(width: 20)
            Button(action: {
                dismiss()
            }) {
                Text("Cancel")
                    .foregroundColor(linkColor)
            }
            Spacer()
        }
        NavigationStack {
            VStack {
                HStack {
                    Text("Replace Component")
                        .font(.system(size: 30))
                        .padding(.vertical, 8)
                        .padding(.leading, 20)
                        .foregroundColor(foreground)
                    
                    Spacer()
                }
                Spacer().frame(height: 2)
                ScrollView {
                    HStack {
                        Spacer().frame(width: 20)
                        VStack {
                            ComponentInfoView(component: component)
                            HStack {
                                DateComponentEditor(title: "Replacement Date", placeholder: "", editable: true, value: $replacementDate)
                                Spacer()
                            }
                            MultiSelectComponentEditor(title: "Replacement Reason", placeholder: "", value: $replacementReason, options: ReplacementReason.allCases.map{$0.rawValue})
                            
                            HStack {
                                Text("You can replace this with the same component or choose a new one")
                                Spacer()
                            }
                            
                            Toggle("Replace with Same", isOn: $replaceWithExisting)
                                .tint(Color(red: 1.0, green: 0.3, blue: 0.46))
                            
                            if replaceWithExisting == false {
                                AddComponentView(bikeId: bikeId, isPresentingPopover: false,
                                                 componentFamily: component.family.rawValue,
                                                 componentType: component.type,
                                                 brand: component.brand ?? "",
                                                 weight: component.weight,
                                                 expectedMileage: component.distanceSinceLastMaintenance,
                                                 expectedLifeInHours: component.timeSinceLastMaintenance,
                                                 maintenanceMileage: component.maintenanceMileage,
                                                 maintenanceTimespan: component.maintenanceTimespan,
                                                 componentToReplace: component,
                                                 replacementReason: $replacementReason)
                                
                            }
                            else {
                                HStack {
                                    VStack {
                                        Divider()
                                        HStack {
                                            Text("Comments")
                                            Spacer()
                                        }
                                        TextEditor(text: $comments)
                                            .foregroundStyle(.secondary)
                                            .frame(height: 100)
                                            .padding()
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(foreground, lineWidth: 1)
                                            )
                                    }
                                }
                                .padding(.bottom, 10)
                                HStack {
                                    Spacer()
                                    Button("Save"){
                                        Task {
                                            await userData.replaceComponentAsync(bikeId: bikeId,
                                                                                 component: component,
                                                                                 replacementDate: replacementDate,
                                                                                 replacement: nil,
                                                                                 comment: comments)
                                        }
                                        dismiss()
                                    }
                                    .tint(.black)
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 10)
                                    .background(gradientBackground)
                                    .cornerRadius(10)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }
                        Spacer().frame(width: 20)
                    }
                }
            }
        }
    }
}

#Preview {
    ReplaceComponent(bikeId: "0", component: Component(id: "123", bikeId: "1", family: ComponentFamily.other, type: "none", name: "abc", brand: nil, model: nil, weight: nil, totalMileageUsed: 0, totalTimeUsed: 0, installedAt: Date()))
}
