//
//  DataSources.swift
//  ValoVision
//
//  Created by Azzam Ubaidillah on 17/08/23.
//

import Foundation
import Alamofire

class DataSources {
    
    func fetchAgents(completion: @escaping (Result<AgentsModel, Error>) -> Void) {

        AF.request("https://valorant-api.com/v1/agents?isPlayableCharacter=true", method: .get)
            .validate()
            .responseDecodable(of: AgentsModel.self) { response in
                switch response.result {
                case let .success(agentResponse):
                    completion(.success(agentResponse))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
