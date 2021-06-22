//
//  Favoritos.swift
//  Nospresso
//
//  Created by Elias Medeiros on 19/06/21.
//

import Foundation

protocol FavoritosProtocolo {
    func estaFavoritado(cafe: Cafe) -> Bool
    func adicionar(cafe: Cafe)
    func remover(cafe: Cafe)
    func limpar()
    func listar() -> [Cafe]
}

class Favoritos {
    static let instancia = Favoritos()

    private let padroesDeUsuario = UserDefaults.standard
    private let chave = "favoritosq30984t6yq-394tr"

    private init() {
        buscarDoArmazenamentoLocal()
    }

    private var cafes: Set<Cafe> = [] {
        didSet {
            atualizarBanco()
        }
    }

    private func atualizarBanco() {
        guard let dadosJson = try? JSONEncoder().encode(cafes) else { return }

        padroesDeUsuario.setValue(dadosJson, forKey: chave)
    }

    private func buscarDoArmazenamentoLocal() {
        guard let dados = padroesDeUsuario.data(forKey: chave),
              let favoritos = try? JSONDecoder().decode([Cafe].self, from: dados) else { return }

        cafes = Set(favoritos)
    }
}

extension Favoritos: FavoritosProtocolo {
    func estaFavoritado(cafe: Cafe) -> Bool {
        cafes.contains(cafe)
    }

    func adicionar(cafe: Cafe) {
        cafes.insert(cafe)
    }

    func remover(cafe: Cafe) {
        cafes.remove(cafe)
    }

    func limpar() {
        cafes.removeAll()
    }

    func listar() -> [Cafe] {
        return Array(cafes)
    }
}
