//
//  FavoritosMock.swift
//  NospressoTests
//
//  Created by Elias Medeiros on 19/06/21.
//

import Foundation
@testable import Nospresso

class FavoritosMock {
    var cafes: Set<Cafe> = []

}

extension FavoritosMock: FavoritosProtocolo {
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

class APIMock: APIProtocolo {

    var sucesso: Decodable?
    var erro: ErroRequisicao?

    init(sucesso: Decodable) {
        self.sucesso = sucesso
    }

    init(erro: ErroRequisicao) {
        self.erro = erro
    }

    func requisitar<T>(endpoint: Endpoint, sucesso: @escaping ResultadoSucesso<T>, falha: @escaping ResultadoFalha) where T : Decodable {
        if let erro = erro {
            falha(erro)
            return
        }

        if let modelo = self.sucesso as? T {
            sucesso(modelo)
        }
    }
}
