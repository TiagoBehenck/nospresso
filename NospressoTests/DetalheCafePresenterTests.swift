//
//  DetalheCafePresenterTests.swift
//  NospressoTests
//
//  Created by Elias Medeiros on 19/06/21.
//

import XCTest
@testable import Nospresso

class DetalheCafePresenterTests: XCTestCase {

    let cafe: Cafe = Cafe(id: 1,
                          nome: "Cafézão",
                          preco: 1,
                          descricao: "Baita café",
                          imagem: "seila",
                          intensidade: 8,
                          medidas: [.espresso, .lungo],
                          origem: nil,
                          torrefacao: nil,
                          perfilAromatico: nil)

    let favoritosMock = FavoritosMock()

    lazy var apiMock = APIMock(sucesso: cafe)

    lazy var tela = DetalheViewMock()

    lazy var presenter = DetalhesCafePresenter(api: apiMock,
                                               cafe: cafe,
                                               favoritos: favoritosMock,
                                               tela: tela)

    func teste_telaCarregouComSucesso() {
        // acao
        presenter.telaCarregou()

        // asserção
        XCTAssertEqual(cafe.id, tela.cafeRecebido?.id)
    }

    func teste_telaCarregouComFalha() {
        // com essa chamada falha porque o presenter é instanciado antes da api ser definida com mock de erro
        //presenter.telaCarregou()

        // arranjo
        apiMock = .init(erro: .semDados)

        // acao
        presenter.telaCarregou()

        // asserção
        XCTAssertNotNil(tela.erroRecebido)
    }

    func teste_favoritou() {
        presenter.favoritou()

        XCTAssertTrue(favoritosMock.estaFavoritado(cafe: cafe))
        XCTAssertTrue(tela.foiAtualizado == true)
    }

    func teste_desfavoritou() {
        // arranjo
        presenter.favoritou()

        // acao
        presenter.favoritou()

        // asserção
        XCTAssertTrue(tela.foiAtualizado == false)
    }

}
