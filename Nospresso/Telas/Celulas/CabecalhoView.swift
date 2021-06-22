//
//  CabecalhoView.swift
//  Nospresso
//
//  Created by Elias Medeiros on 19/06/21.
//

import UIKit

class CabecalhoView: UIView {

    @IBOutlet weak var cabecalhoLabel: UILabel!

    func configurar(texto: String) {
        cabecalhoLabel.text = texto
    }

}
