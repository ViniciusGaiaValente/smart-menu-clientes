//
//  CatalogoViewController.swift
//  Smart Menu Clientes
//
//  Created by Vinicius Valente on 05/04/19.
//  Copyright © 2019 Vinicius Valente. All rights reserved.
//

import UIKit

class CatalogoViewController: UIViewController {

    //MARK: - Atributos
    
    var timer: Timer?
    var filtro: String?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionRestaurantes: UICollectionView!
    
    //MARK: - IBActions
    
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        
        collectionRestaurantes.delegate = self
        collectionRestaurantes.dataSource = self
        searchBar.delegate = self
        
        ajustesDeLayout()
        
        setarMesa()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        timerAtualizaRestaurantes(intervalo: 2)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        desligaTimerRestaurantes()
    }
    
    //MARK: - Metodos
    
    func setarMesa() {
        
        let alerta = UIAlertController(title: "Atenção", message: "em qual mesa vc esta?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { [weak alerta] (_) in
            
            guard let mesa = alerta?.textFields?[0].text else { print("erro"); return }
            Mesa = mesa
        })
        
        alerta.addTextField(configurationHandler: nil)
        alerta.addAction(ok)
        
        self.present(alerta, animated: true)
    }
    
    func timerAtualizaRestaurantes(intervalo: Double) {
        
        atualizaListaDeRestaurantes()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(atualizaListaDeRestaurantes), userInfo: nil, repeats: false)
        
        timer = Timer.scheduledTimer(timeInterval: intervalo, target: self, selector: #selector(atualizaListaDeRestaurantes), userInfo: nil, repeats: true)
    }
    
    func desligaTimerRestaurantes() {
        
        timer?.invalidate()
    }
    
    @objc func atualizaListaDeRestaurantes() {
        
        recuperaListaGeralDeRestaurantesDoServidor(filtro: filtro)
        
        collectionRestaurantes.reloadData()
    }
    
    @objc func segueParaCardapio() {
        
        self.performSegue(withIdentifier: "segueParaCardapio", sender: nil)
    }
    
    func ajustesDeLayout() {
        
        //AS 4 LINHAS ABAIXO DEIXAM A "navigationBar" COMPLETAMENTE TRANSPARENTE
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
}

extension CatalogoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListaDeRestaurantes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let restaurante = ListaDeRestaurantes?[indexPath.row] else { return UICollectionViewCell() }
        guard let fotoData = restaurante.fotoData else { return UICollectionViewCell() }
        
        let cell = collectionRestaurantes.dequeueReusableCell(withReuseIdentifier: "celulaRestaurante", for: indexPath) as! RestauranteCollectionViewCell
        
        cell.imageFoto.image = UIImage(data: fotoData) ?? UIImage(named: "camera.png")
        cell.labelNome.text = restaurante.nome
        
        
        //Configuracoes de Design
        
        //CORTA A IMAGEM PARA QUE SE ENCAIXE NO ESPACO DEFINIDO (NESCESSARIO QUANDO SE USA O CONTENT MODE: "Aspect Fill"
        cell.imageFoto.layer.masksToBounds = true
        
        //CRIAR CONTORNO PARA A CELULA
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView.bounds.width/2 - 30
        
        return  CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if ListaDeRestaurantes == nil { return }
        
        RestauranteEscolido = ListaDeRestaurantes![indexPath.row]
        
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardapioController") as! CardapioViewController
        navigationController?.pushViewController(view, animated: true)
    }
}

extension CatalogoViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            filtro = nil
        } else {
            filtro = searchText
        }
    }
}
