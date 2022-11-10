//
//  DatabaseManager.swift
//  MStudy
//
//  Created by Drew Scheffer on 11/10/22.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Firestore.firestore()
    
    private init() {}
    
    public func insert(post: Post, user: User, competion: @escaping(Bool)->Void){
        //TODO: impliment this...
    }
    
    public func getAllPosts(competion: @escaping([Post])->Void){
        //TODO: impliment this...
    }
    
    public func getPosts(for user: User, competion: @escaping([Post])->Void){
        //TODO: impliment this...
    }
    
    public func insertUser(user: User, completion: @escaping((Bool))->Void){
        //TODO: impliment this...
        let documentID = user.email.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_")
        
        let data = [
            "email": user.email,
            "name": user.name
        ]
        
        database.collection("users").document(documentID).setData(data) { error in
            completion(error==nil)
        }
    }
}
