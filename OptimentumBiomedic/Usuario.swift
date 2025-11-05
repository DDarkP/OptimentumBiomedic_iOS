//
//  Usuario.swift
//  OptimentumBiomedic
//
//  Created by Telematica on 4/11/25.
//

import Foundation

struct Usuario: Identifiable, Codable, Equatable {
    let id = UUID()
    var nombre: String
    var email: String
    var password: String
}
