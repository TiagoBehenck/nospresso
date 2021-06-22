//
//  API.swift
//  Nospresso
//
//  Created by Treinamento on 05/06/21.
//

import Foundation

typealias ResultadoSucesso<T: Decodable> = (T) -> Void
typealias ResultadoFalha = (ErroRequisicao) -> Void

protocol APIProtocolo {
    func requisitar<T>(endpoint: Endpoint, sucesso: @escaping ResultadoSucesso<T>, falha: @escaping ResultadoFalha)
}

class API: APIProtocolo {
    private let urlBase = "http://localhost:3000"
    
    //func requisitar<T: Decodable>(endpoint: Endpoint, sucesso: @escaping (T) -> Void, falha: @escaping ResultadoFalha) {
    func requisitar<T>(endpoint: Endpoint, sucesso: @escaping ResultadoSucesso<T>, falha: @escaping ResultadoFalha) {
        guard var url = URL(string: urlBase) else {
            falha(.urlInvalida(mensagem: "url inválida: \(urlBase)"))
            return
        }
        
        url.appendPathComponent(endpoint.url)
        
        let requisicao = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requisicao) { dados, _, erro in
            
            guard erro == nil else {
                falha(.falhou(mensagem: erro!.localizedDescription))
                return
            }
            
            guard let dados = dados else {
                falha(.semDados)
                return
            }
            
            let decodificador = JSONDecoder()
            do {
                let dadosDecodificados = try decodificador.decode(T.self, from: dados)
                sucesso(dadosDecodificados)
            } catch {
                falha(
                    .falhaNaDecodificacao(
                        mensagem: error.localizedDescription,
                        dadosRecebidos: String(data: dados, encoding: .utf8)
                    )
                )
            }
            
            /*
            if let dadosDecodificados = try? decodificador.decode(T.self, from: dados) {
                sucesso(dadosDecodificados)
            }
            */

        }.resume()
    }
    
}
