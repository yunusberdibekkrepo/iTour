//
//  EditDestinationView.swift
//  iTour
//
//  Created by Yunus Emre Berdibek on 13.01.2024.
//

import SwiftData
import SwiftUI

struct EditDestinationView: View {
    @Bindable var destination: Destination
    @State private var newSightName = ""

    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)

            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }

            Section("Sights") {
                ForEach(destination.sights) {
                    Text($0.name)
                }

                HStack(content: {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    Button("Add", action: addSight)
                })
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }

    func addSight() {
        guard !newSightName.isEmpty else { return }
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let condatiner = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example Destination", details: "Example details go here and will automatically expand vertically as there arer edited.")
        return EditDestinationView(destination: example)
            .modelContainer(condatiner)
    } catch {
        fatalError("Failed to create model container.")
    }
}
