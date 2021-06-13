//
//  KeyEntity.swift
//  Hu&Te
//
//  Created by BigSur on 03/06/2021.
//

import Foundation
class KeyEntity: Codable {
    let key, lastUpdate, keyBBC, keyBBC1: String?

    enum CodingKeys: String, CodingKey {
        case key
        case lastUpdate = "last-update"
        case keyBBC, keyBBC1
    }

    init(key: String?, lastUpdate: String?, keyBBC: String?, keyBBC1: String?) {
        self.key = key
        self.lastUpdate = lastUpdate
        self.keyBBC = keyBBC
        self.keyBBC1 = keyBBC1
    }
}
