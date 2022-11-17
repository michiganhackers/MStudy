//
//  Post.swift
//  MStudy
//
//  Created by Drew Scheffer on 11/10/22.
//

import Foundation

struct Post {
    let title: String               //or class
    let group_size: Int?            //nil = no limit
    let study_location: String

    let text: String                //Any additional info
    let headerImageUrl: URL?        //Some profile picture
    let creator_email: String       //email of the person that made the post
    let identifier: String          //random identifier of the post
    let timestamp: TimeInterval     //Timestamp when the post was created
}
