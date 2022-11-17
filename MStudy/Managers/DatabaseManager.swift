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
    
    //DESCRIPTION: This method posts a POST object from a specific user to firebase
    //RETURNS: Completion handler specifying if an error occured
    public func insert(post: Post, email: String, completion: @escaping(Bool)->Void){
        let userEmail = email.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_")
        
        let data : [String: Any] = [
            "title": post.title,
            "group_size": post.group_size as Any,
            "study_location": post.study_location,
            "text": post.text,
            "headerImageUrl": "",
            "creator_email": post.creator_email,
            "id": post.identifier,
            "created": post.timestamp
        ]
        
        database.collection("users").document(userEmail).collection("posts").document(post.identifier).setData(data) { error in
            completion(error == nil)
        }
    }
    
    //DESCRIPTION: This method fetches ALL posts by ALL users from firebase.
    //RETURNS: Completion handler giving all posts registered on firebase...
    public func getAllPosts(completion: @escaping([Post])->Void){
        database.collection("users").getDocuments { [weak self] snapshot, error in
            guard let documents = snapshot?.documents.compactMap({ $0.data() }), error == nil else {
                return
            }
            
            let emails: [String] = documents.compactMap({ $0["email"] as? String })
            print("Retrieving posts from the following emails:")
            print(emails)
            
            guard !emails.isEmpty else {
                completion([])
                return
            }
            
            let group = DispatchGroup()
            var result: [Post] = []
            
            for email in emails {
                group.enter()
                self?.getPosts(for: email) { userPosts in
                    defer {
                        group.leave()
                    }
                    result.append(contentsOf: userPosts)
                }
            }
            
            group.notify(queue: .global()) {
                print("Number of retrieved posts: \(result.count)")
                completion(result)
            }
        }
    }
    
    //DESCRIPTION: This method fetches ALL posts made by a specific user...
    //RETURNS: Completion handler giving all posts from that user
    public func getPosts(for email: String, completion: @escaping([Post])->Void){
        let userEmail = email.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_")
        
        database.collection("users").document(userEmail).collection("posts").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents.compactMap({ $0.data() }),
                  error == nil else {
                return
            }

            let posts: [Post] = documents.compactMap({ dictionary in
                guard let title = dictionary["title"] as? String,
                      let group_size = dictionary["group_size"] as? Int?,
                      let study_location = dictionary["study_location"] as? String,
                      let text = dictionary["text"] as? String,
                      let imageUrlString = dictionary["headerImageUrl"] as? String,
                      let creator_email = dictionary["creator_email"] as? String,
                      let identifier = dictionary["id"] as? String,
                      let created = dictionary["created"] as? TimeInterval else {
                    
                    print("Invalid post fetch conversion")
                    return
                }
            
                //Create post object and return it...
                let post = Post(title: title, group_size: group_size, study_location: study_location, text: text, headerImageUrl: nil, creator_email: creator_email, identifier: identifier, timestamp: created)
                return post
            })

            completion(posts)
        }
    }
    
    //DESCRIPTION: This method inserts a specific user into the database
    //RETURNS: Completion handler specifying if an error occured...
    public func insertUser(user: User, completion: @escaping((Bool))->Void){
        let documentID = user.email.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_")
        
        //You can modify the information that is stored with a user...
        let data = [
            "email": user.email,
            "name": user.name
        ]
        
        database.collection("users").document(documentID).setData(data) { error in
            completion(error==nil)
        }
    }
    
    //DESCRIPTION: This method returns a User given their email address. Assumes the user is already inserted into the database
    //RETURNS: Completion handler specifying the user..
    public func getUser(email: String, completion: @escaping (User?) -> Void){
        let documentID = email.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_")
        
        database.collection("users").document(documentID).getDocument { snapshot, error in
            guard let data = snapshot?.data() as? [String: String], error == nil else {
                return
            }
            
            guard let name = data["name"] else {
                return
            }
            
            let user = User(name: name, email: email)
            completion(user)
        }
    }
}
