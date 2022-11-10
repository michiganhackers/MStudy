//
//  AuthManager.swift
//  MStudy
//
//  Created by Drew Scheffer on 11/10/22.
//

import Foundation
import FirebaseAuth


//This class has 4 responsibilities: Signing in, Signing up, signing out, telling if we're already signed in
final class AuthManager{
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private init() {}
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    public func signUp(email: String, password: String, completion: @escaping(Bool)->Void){
        //TODO: Do some error checking with the email and password!
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                print(error?.localizedDescription)
                completion(false)
                return
            }

            // Account Created
            completion(true)
        }
    }
    
    public func signIn(email: String, password: String, completion: @escaping(Bool)->Void){
        //TODO: Do some error checking with the email and password!!
        
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }

            completion(true)
        }
    }
    
    public func signOut(completion: (Bool)->Void){
        do {
            try auth.signOut()
            completion(true)
        } catch {
            print(error)
            completion(false)
            
        }
    }
}
