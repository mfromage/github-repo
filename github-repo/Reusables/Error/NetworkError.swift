//
//  NetworkError.swift
//  github-repo
//
//  Created by Michael Michael on 15.06.22.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case errorResponse(message: String)
}
