//
//  CafesViewController.swift
//  Nospresso
//
//  Created by Fabricio Cordella on 12/06/21.
//

import UIKit

class CafesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var telaDeErro: UIView!
    
    lazy var api: API = API()
    var capsulas: [Capsulas] = []
    var estado: Estado = .carregando {
        didSet {
            // TODO: naah...
            switch estado {
            case .carregando:
                tableView.isHidden = true
                activityIndicator.isHidden = false
                telaDeErro.isHidden = true
            case .dadosProntos:
                tableView.isHidden = false
                activityIndicator.isHidden = true
                telaDeErro.isHidden = true
            case .erro:
                tableView.isHidden = true
                activityIndicator.isHidden = true
                telaDeErro.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurarTabela()
        requisitarDados()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configurarBarraDeNavegacao()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }
    
    private func configurarTabela() {
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configurarBarraDeNavegacao() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .cafes
        navigationController?.navigationBar.tintColor = .label
    }
}

extension CafesViewController {
    
    enum Estado {
        case carregando
        case dadosProntos
        case erro
    }
    
}

extension CafesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 50 }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let secao = capsulas[section]
        let cabecalho = UINib(nibName: "CabecalhoView", bundle: Bundle.main)
            .instantiate(withOwner: nil, options: nil).first as? CabecalhoView

        cabecalho?.configurar(texto: secao.categoria)

        return cabecalho
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quadroDeEstoria = UIStoryboard(name: "Produtos", bundle: .main)

        guard let controlador = quadroDeEstoria
                .instantiateViewController(withIdentifier: DetalhesCafeViewController.identificador)
                as? DetalhesCafeViewController else { return }

        let cafe = capsulas[indexPath.section].cafes[indexPath.row]

        let presenter = DetalhesCafePresenter(
            api: api,
            cafe: cafe,
            tela: controlador
        )

        controlador.presenter = presenter

//        navigationController?.pushViewController(controlador, animated: true)
        // apresentacao modal
//        controlador.modalPresentationStyle = .fullScreen
//        controlador.modalTransitionStyle = .flipHorizontal
//        present(controlador, animated: true)
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        capsulas[section].categoria
//    }
}

extension CafesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        capsulas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        capsulas[section].cafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "cafe-celula", for: indexPath)
        
        if let celulaDeCafe = celula as? CafeTableViewCell {
            celulaDeCafe.configurar(com: capsulas[indexPath.section].cafes[indexPath.row])
        }
        
        return celula
    }
}

extension CafesViewController {
    func requisitarDados() {
        estado = .carregando
        api.requisitar(endpoint: .capsulas) { [weak self] (capsulas: [Capsulas]) in
            guard let self = self else { return }
            
            self.capsulas = capsulas
            DispatchQueue.main.async {
                self.estado = .dadosProntos
                self.tableView.reloadData()
            }
        } falha: { [weak self] (erro) in
            DispatchQueue.main.async {
                self?.estado = .erro
            }
            print(erro)
        }
    }
}
