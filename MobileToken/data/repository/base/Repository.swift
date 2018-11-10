//
//  Repository.swift
//  alpha
//
//  Created by Arash Foumani on 6/27/18.
//  Copyright © 2018 Nuesoft. All rights reserved.
//

import Foundation

protocol Repository {
    
    associatedtype Model
    associatedtype Identifier
    
    func create(_: Model, onDone: ((RepositoryResponse<Model>) -> ())?)
    func get(identifier: Identifier, onDone: ((RepositoryResponse<Model>) -> ())?)
    func getAll(onDone: ((RepositoryResponse<[Model]>) -> ())?)
    func update(_: Model, onDone: ((RepositoryResponse<Model>) -> ())?)
    func update(_: [Model], onDone: ((RepositoryResponse<[Model]>) -> ())?)
    func delete(_: Model, onDone: ((RepositoryResponse<Model>) -> ())?)
    func delete(_: [Model], onDone: ((RepositoryResponse<[Model]>) -> ())?)
}
