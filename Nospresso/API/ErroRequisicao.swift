//
//  ErroRequisicao.swift
//  Nospresso
//
//  Created by Treinamento on 05/06/21.
//

import Foundation

enum ErroRequisicao: Error {
    case urlInvalida(mensagem: String)
    case falhou(mensagem: String)
    case semDados
    case falhaNaDecodificacao(mensagem: String, dadosRecebidos: String?)
}
