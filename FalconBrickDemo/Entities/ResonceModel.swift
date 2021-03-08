//
//  ResonceModel.swift
//  FalconBrickDemo
//
//  Created by Abhishek Singh on 06/03/21.
//  Copyright © 2021 Girish. All rights reserved.
//

import Foundation

struct BlocksModel: Codable {
    var block_name: String
    let units: [Units]?
    struct Units: Codable {
        let title, apt, floor: String?
        let activities: [Activities]?
        
        struct Activities: Codable {
            let activity_name, activity_status, step_name: String?
            let progress: Int

        }
    }
}

struct BlockRequest<T> {
    let decodeTyepeModel: T.Type
    let bundleIdentifier: String
}
