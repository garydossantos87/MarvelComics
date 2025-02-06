//
//  ComicListCoordinatorProtocol.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 26/1/25.
//

protocol ComicListCoordinatorProtocol: BaseCoordinatorProtocol {
    func openComicDetail(with comic: Comic.List.Model)
}
