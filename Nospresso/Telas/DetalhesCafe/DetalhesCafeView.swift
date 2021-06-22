//
//  DetalhesCafeView.swift
//  Nospresso
//
//  Created by Elias Medeiros on 19/06/21.
//

import Foundation

protocol DetalhesCafeViewProtocolo: AnyObject {
    func recebeu(cafe: Cafe)
    func recebeu(erro: String)
    func atualizarFavorito(valor: Bool)
}
