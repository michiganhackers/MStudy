//
//  StorageManager.swift
//  MStudy
//
//  Created by Drew Scheffer on 11/10/22.
//

import Foundation
import FirebaseStorage

//TODO: could use this to upload images to the app...
final class StorageManager{
    static let shared = StorageManager()
    
    private let container = Storage.storage()
    
    private init() {}
}
