//
//  Refrence.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 08/10/2022.
//

import Foundation
import Firebase
var DBref = Database.database(url: "https://photeplay-default-rtdb.europe-west1.firebasedatabase.app/").reference()

enum FcollectionRefrence : String {
    case User
}

func reference(_ collectionReference : FcollectionRefrence) -> String {
    return collectionReference.rawValue
}


