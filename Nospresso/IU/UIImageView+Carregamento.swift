//
//  UIImageView+Carregamento.swift
//  Nospresso
//
//  Created by Treinamento on 12/06/21.
//

import UIKit
import Nuke

extension UIImageView {
    
    func carregarImagem(da url: String) {
        guard let url = URL(string: url) else { return }
        
        Nuke.loadImage(with: url,
                       options: ImageLoadingOptions(placeholder: UIImage(systemName: "photo")),
                       into: self)
    }
    
}
