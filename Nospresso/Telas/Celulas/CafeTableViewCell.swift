//
//  CafeTableViewCell.swift
//  Nospresso
//
//  Created by Fabricio Cordella on 12/06/21.
//

import UIKit

class CafeTableViewCell: UITableViewCell {

    @IBOutlet weak var capsulaImageView: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var intensidadeLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        intensidadeLabel.isHidden = false
    }
    
    func configurar(com cafe: Cafe) {
        capsulaImageView.carregarImagem(da: cafe.imagem)
        tituloLabel.text = cafe.nome
        descricaoLabel.text = cafe.descricao.capitalized
        precoLabel.text = cafe.preco.comoDinheiro
        
        if let intensidade = cafe.intensidade {
            intensidadeLabel.text = "Intensidade: \(intensidade)"
        } else {
            intensidadeLabel.isHidden = true
        }
    }
}
