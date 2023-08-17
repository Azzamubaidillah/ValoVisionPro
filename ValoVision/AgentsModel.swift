//
//  AgentsModel.swift
//  ValoVision
//
//  Created by Azzam Ubaidillah on 17/08/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let agentsModel = try? JSONDecoder().decode(AgentsModel.self, from: jsonData)

import Foundation

// MARK: - AgentsModel
struct AgentsModel: Codable {
    let status: Int
    let data: [Agents]
}

// MARK: - Datum
struct Agents: Codable, Hashable, Equatable {
    let uuid, displayName, description, developerName: String
    let characterTags: [String]?
    let displayIcon, displayIconSmall: String
    let bustPortrait, fullPortrait, fullPortraitV2: String?
    let killfeedPortrait: String
    let background: String?
    let backgroundGradientColors: [String]
    let assetPath: String
    let isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest, isBaseContent: Bool
    let role: Role?
    let abilities: [Ability]
    let voiceLine: VoiceLine
    
    static func == (lhs: Agents, rhs: Agents) -> Bool {
            return lhs.uuid == rhs.uuid
        }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
        }
}

// MARK: - Ability
struct Ability: Codable {
    let slot: Slot
    let displayName, description: String
    let displayIcon: String?
}

enum Slot: String, Codable {
    case ability1 = "Ability1"
    case ability2 = "Ability2"
    case grenade = "Grenade"
    case passive = "Passive"
    case ultimate = "Ultimate"
}

// MARK: - Role
struct Role: Codable {
    let uuid: String
    let displayName: DisplayName
    let description: String
    let displayIcon: String
    let assetPath: String
}

enum DisplayName: String, Codable {
    case controller = "Controller"
    case duelist = "Duelist"
    case initiator = "Initiator"
    case sentinel = "Sentinel"
}

// MARK: - VoiceLine
struct VoiceLine: Codable {
    let minDuration, maxDuration: Double
    let mediaList: [MediaList]
}

// MARK: - MediaList
struct MediaList: Codable {
    let id: Int
    let wwise: String
    let wave: String
}
