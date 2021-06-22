//
//  DetalhesCafeViewController.swift
//  Nospresso
//
//  Created by Elias Medeiros on 19/06/21.
//

import UIKit

class DetalhesCafeViewController: UIViewController {

    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var intensidadeStackView: ContadorIntensidadeStackView!
    @IBOutlet weak var intensidadeLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var origemLabel: UILabel!
    @IBOutlet weak var torrefacaoLabel: UILabel!
    @IBOutlet weak var perfilAromaticoLabel: UILabel!

    var presenter: DetalhesCafePresenterProtocolo?

    @IBAction func adicionouASacola(_ sender: Any) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.telaCarregou()
    }

    @objc
    private func toqueBotaoFavorito() {
        presenter?.favoritou()
    }
}

// MARK: protocolo da view
extension DetalhesCafeViewController: DetalhesCafeViewProtocolo {
    func recebeu(cafe: Cafe) {
        DispatchQueue.main.async {
            self.cafeImageView.carregarImagem(da: cafe.imagem)
            self.intensidadeStackView.configurar(com: cafe)
            self.intensidadeLabel.text = "intensidade: \(cafe.intensidade)"
            self.precoLabel.text = cafe.preco.comoDinheiro
            self.descricaoLabel.text = cafe.descricao
            self.origemLabel.text = cafe.origem
            self.torrefacaoLabel.text = cafe.torrefacao
            self.perfilAromaticoLabel.text = cafe.perfilAromatico

            self.title = cafe.nome
        }
    }

    func recebeu(erro: String) {
        // TODO
    }

    func atualizarFavorito(valor: Bool) {
        let imagem = valor ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")

        let botaoFavorito = UIBarButtonItem(image: imagem,
                                            style: .plain,
                                            target: self,
                                            action: #selector(toqueBotaoFavorito))

        navigationItem.rightBarButtonItem = botaoFavorito
    }
}

extension DetalhesCafeViewController {
    static var identificador: String {
        String(describing: DetalhesCafeViewController.self)
    }
}
