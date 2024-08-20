//
//  FavoriteRocket.swift
//  SpaceX iOS
//
//  Created by Vestel on 20.08.2024.
//

import RealmSwift

class FavoriteRocket: Object {
    @Persisted(primaryKey: true) var id: String = ""
}
