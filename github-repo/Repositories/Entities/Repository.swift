//
//  Repository.swift
//  github-repo
//
//  Created by Michael Michael on 14.06.22.
//

import Foundation

struct RepositorySearchResponse: Codable {
    
    let items: [Repository]
    
    struct Repository: Codable {
        
        let id: Int
        
        let nodeId: String
        
        let name: String
        
        let fullName: String
        
        enum CodingKeys: String, CodingKey {
            
            case id
            case nodeId = "node_id"
            case name
            case fullName = "full_name"
        }
    }

}

struct RepositoryBranch: Codable {
    
    let name: String
}

