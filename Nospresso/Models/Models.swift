//
//  Models.swift
//  Nospresso
//
//  Created by Treinamento on 05/06/21.
//

import Foundation

struct Capsulas: Decodable {
    let categoria: String
    let cafes: [Cafe]
}

struct Cafe: Codable, Hashable {
    let id: Int
    let nome: String
    let preco: Double
    let descricao: String
    let imagem: String
    let intensidade: Int?
    let medidas: [MedidaCafe]
    let origem: String?
    let torrefacao: String?
    let perfilAromatico: String?
    
    enum MedidaCafe: String, Codable {
        case ristretto
        case espresso
        case lungo
    }
    
    enum CodingKeys: String, CodingKey {
        case id, nome, descricao, imagem, medidas, origem, torrefacao, perfilAromatico, intensidade
        case preco = "precoUnitario"
    }
}

struct CategoriaAcessorio: Codable {
    let categoria: String
    let itens: [Acessorio]
}

struct Acessorio: Codable {
    let id: Int
    let nome: String
    let preco: Int
    let imagem: String
    let descricao: String?
}

struct Maquina: Codable {
    let id: Int
    let nome: String
    let preco: Int
    let descricao: String
    let imagem: String
}
