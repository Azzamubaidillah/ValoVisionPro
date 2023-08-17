//
//  ContentView.swift
//  ValoVision
//
//  Created by Azzam Ubaidillah on 14/08/23.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct MainView: View {
    @State private var selectedAgentIndex = 0
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationSplitView {
            if let agents = viewModel.agents {
                List {
                    ForEach(Array(agents.data.enumerated()), id: \.element) { index, agent in
                        let isSelected = index == selectedAgentIndex

                        HStack {
                            Text("\(index + 1).")
                                .font(.headline)
                                .foregroundColor(isSelected ? Color(UIColor(hex: "#fd4556")) : .white)

                            Text(agent.displayName.uppercased())
                                .onTapGesture {
                                    selectedAgentIndex = index
                                }
                                .font(.largeTitle)
                                .foregroundColor(isSelected ? Color(UIColor(hex: "#fd4556")) : .white)
                        }
                    }
                }
                .navigationTitle("Agents")

            } else {
                ProgressView()
            }

        } detail: {
            if let agent = viewModel.agents?.data[selectedAgentIndex] {
                HStack(alignment: .top) {
                    AsyncImage(
                        url: URL(string: agent.fullPortrait ?? ""),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .frame(width: 380)

                    VStack(alignment: .leading) {
                        Text("// ROLE")
                        HStack {
                            Text(agent.role?.displayName.rawValue.uppercased() ?? "")
                                .font(.title)

                            AsyncImage(
                                url: URL(string: agent.role?.displayIcon ?? ""),
                                content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            )
                            .frame(width: 30)
                        }
                        .padding(.vertical, 16)

                        Text("// BIOGRAPHY")
                        Text(agent.description)
                            .font(.body)
                            .padding(.vertical, 8)
                    }
                    .padding(16)
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .navigationTitle(agent.displayName.uppercased())
                .padding()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.fetchAgents()
        }
    }
}

#Preview {
    MainView()
}

extension UIColor {
    convenience init(hex: String) {
        var sanitizedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        sanitizedHex = sanitizedHex.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: sanitizedHex).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
