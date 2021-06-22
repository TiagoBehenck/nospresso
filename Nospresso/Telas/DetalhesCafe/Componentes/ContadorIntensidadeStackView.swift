//
//  ContadorIntensidadeStackView.swift
//  Nospresso
//
//  Created by Elias Medeiros on 19/06/21.
//

import UIKit

class ContadorIntensidadeStackView: UIStackView {

    private let intensidadeMaxima = 13
    private let tamanhoBolinha: CGFloat = 7

    required init(coder: NSCoder) {
        super.init(coder: coder)

        axis = .horizontal
        distribution = .fill
        spacing = 1.5
    }

    func configurar(com cafe: Cafe) {
        if let intensidade = cafe.intensidade {
            adicionarBolinhas(para: intensidade)
        }
    }

    private func adicionarBolinhas(para quantidade: Int) {
        let quantidadeDeBolasVazias = intensidadeMaxima - quantidade

        for _ in 0..<quantidade {
            let bolinha = gerarBolinha(preenchido: true)

            addArrangedSubview(bolinha)
        }

        for _ in 0..<quantidadeDeBolasVazias {
            let bolinha = gerarBolinha(preenchido: false)

            addArrangedSubview(bolinha)
        }

        addArrangedSubview(.init())
    }

    private func gerarBolinha(preenchido: Bool) -> UIView {
        let bolinha = UIView()

        NSLayoutConstraint.activate([
            bolinha.widthAnchor.constraint(equalToConstant: tamanhoBolinha),
            bolinha.heightAnchor.constraint(equalToConstant: tamanhoBolinha)
        ])

        bolinha.layer.cornerRadius = tamanhoBolinha / 2
        bolinha.layer.borderWidth = 0.4
        bolinha.layer.borderColor = preenchido ? UIColor.black.cgColor : UIColor.bordaIntensidadeVazia?.cgColor
        bolinha.backgroundColor = preenchido ? .intensidadePreenchida : .intensidadeVazia

        return bolinha
    }

}
