//
//  Functions.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 07.02.2021.
//

func setup<Type>(_ object: Type, block: (Type) -> Void) -> Type {
    block(object)
    return object
}

