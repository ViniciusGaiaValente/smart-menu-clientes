//
//  DetalhesViewController.swift
//  Smart Menu Clientes
//
//  Created by Vinicius Valente on 10/04/19.
//  Copyright © 2019 Vinicius Valente. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {
    
    //MARK: - Atributos
    
    var prato: Prato?
    var timer: Timer?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var labelNome: UILabel!
    
    @IBOutlet weak var labelPreco: UILabel!
    
    @IBOutlet weak var textViewDescrissao: UITextView!
    
    @IBOutlet weak var imageFoto: UIImageView!
    
    @IBOutlet weak var constraintHeightFoto: NSLayoutConstraint!
    
    @IBOutlet weak var superViewFoto: UIView!
    
    //MARK: - IBActions
    
    @IBAction func buttonPedirJa(_ sender: UIButton) {
        
        func pedir(action: UIAlertAction) {
        
            guard let nome = RestauranteEscolido?.nome else { print("erro"); return }
            guard let prato = self.prato else { return }
            guard let mesa = Mesa else { return }
            
            print("TESTE")
        
            API.addPedido(pedido: Pedido(restaurante: nome, pratos: [prato], mesa: mesa))
        }
        
        Alerta(controller: self).mostrarAlertaComOk(okAction: pedir, titulo: "Atenção", mensagem: "esse pedido nao pode ser cancelado")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        
        if prato == nil {
            navigationController?.popViewController(animated: true)
        }
        
        ajustesDeLayout()
        configuracoesIniciais()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        timerAtualizaRestaurantes(intervalo: 2)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        desligaTimerRestaurantes()
    }
    
    //MARK: - Metodos
    
    func timerAtualizaRestaurantes(intervalo: Double) {
        
        atualizaListaDeRestaurantes()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(atualizaListaDeRestaurantes), userInfo: nil, repeats: false)
        
        timer = Timer.scheduledTimer(timeInterval: intervalo, target: self, selector: #selector(atualizaListaDeRestaurantes), userInfo: nil, repeats: true)
    }
    
    func desligaTimerRestaurantes() {
        
        timer?.invalidate()
    }
    
    @objc func atualizaListaDeRestaurantes() {
        
        recuperaListaGeralDeRestaurantesDoServidor()
    }
    
    func configuracoesIniciais() {
        
        guard let foto = UIImage(data: prato!.fotoData!) else { return }
        guard let nome = prato?.nome else { return }
        guard let preco = prato?.preco else { return }
        guard let descrissao = prato?.descrissao else { return }
        
        imageFoto.image = foto
        labelNome.text = nome
        labelPreco.text = String(preco)
        textViewDescrissao.text = descrissao
    }
    
    func ajustesDeLayout() {
        

        imageFoto.layer.masksToBounds = true
        imageFoto.layer.cornerRadius = 0
        

        labelNome.layer.masksToBounds = true
        labelNome.layer.cornerRadius = 0
        

        labelPreco.layer.masksToBounds = true
        labelPreco.layer.cornerRadius = 0
        

        textViewDescrissao.layer.masksToBounds = true
        textViewDescrissao.layer.cornerRadius = 0
        
        constraintHeightFoto.constant = view.bounds.width
        superViewFoto.layoutIfNeeded()
    }
}
