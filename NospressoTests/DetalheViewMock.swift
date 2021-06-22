//
//  DetalheViewMock.swift
//  NospressoTests
//
//  Created by Elias Medeiros on 19/06/21.
//

import Foundation
@testable import Nospresso

class DetalheViewMock {
    var cafeRecebido: Cafe?
    var erroRecebido: String?
    var foiAtualizado: Bool?
}

extension DetalheViewMock: DetalhesCafeViewProtocolo {
    func recebeu(cafe: Cafe) {
        cafeRecebido = cafe
    }

    func recebeu(erro: String) {
        erroRecebido = erro
    }

    func atualizarFavorito(valor: Bool) {
        foiAtualizado = valor
    }
}
