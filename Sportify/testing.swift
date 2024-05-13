//
//  testing.swift
//  Sportify
//
//  Created by Febrian Daniel on 18/04/24.
//

import SwiftUI

struct SportSelectionView: View {
    @State private var sports: [String] = ["Football", "Basketball", "Tennis"]
    @State private var selectedSports: Set<String> = []
    @State private var skillLevels: [String: String] = [:] // To hold the skill levels for each sport
    
    var body: some View {
        VStack {
            Text("What kind of sports do you like?")
                .font(.title)
                .padding()
            
            ForEach(sports, id: \.self) { sport in
                VStack(alignment: .leading) {
                    Text(sport)
                        .onTapGesture {
                            if self.selectedSports.contains(sport) {
                                self.selectedSports.remove(sport)
                            } else {
                                self.selectedSports.insert(sport)
                            }
                            print(selectedSports)
                        }
                    TextField("Enter skill level", text: self.binding(for: sport))
                        .padding()
                }.padding()
            }
            
            if !selectedSports.isEmpty {
                Button("Submit") {
                    // Create SportData objects for each selected sport and its corresponding skill level
                    var sportData: [SportData] = []
                    for sport in selectedSports {
                        if let skillLevel = skillLevels[sport] {
                            sportData.append(SportData(sport: sport, skillLevel: skillLevel))
                        }
                    }
                    // Use sportData for further processing or storage
                    print("User's sport data: \(sportData)")
                }
                .padding()
            }
            
            Spacer()
        }
    }
    
    private func binding(for sport: String) -> Binding<String> {
        Binding<String>(
            get: { self.skillLevels[sport, default: ""] },
            set: { self.skillLevels[sport] = $0 }
        )
    }
}

struct SportData {
    var sport: String
    var skillLevel: String
}

#Preview {
    SportSelectionView()
}
