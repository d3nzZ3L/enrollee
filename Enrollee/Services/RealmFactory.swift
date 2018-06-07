//
//  RealmFactory.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 18.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import RealmSwift

class RealmFactory {
    static func getRealm() -> Realm {
        let config = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 4) {
                }
        })
        print(config.fileURL?.absoluteString)
        let realm = try! Realm(configuration: config)
        return realm
    }
}
