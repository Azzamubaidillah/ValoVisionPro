//
//  ViewModel.swift
//  ValoVision
//
//  Created by Azzam Ubaidillah on 17/08/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var agents: AgentsModel?
    @Published var isLoading = false
    private let dataSource = DataSources()
    
    func fetchAgents() {
        isLoading = true

        dataSource.fetchAgents { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(agentsResponse):
                    self?.agents = agentsResponse
                    self?.isLoading = false
                case let .failure(error):
                    print("Error: \(error)")
                    self?.isLoading = false
                }
            }
        }
    }
}
