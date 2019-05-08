//
//  CardapioViewController.swift
//  Smart Menu Clientes
//
//  Created by Vinicius Valente on 09/04/19.
//  Copyright © 2019 Vinicius Valente. All rights reserved.
//

import UIKit

class CardapioViewController: UIViewController {
    
    //MARK: - Atributos
    
    var timer: Timer?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionPratos: UICollectionView!
    
    //MARK: - IBActions
    
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        
        if RestauranteEscolido == nil {
            
            navigationController?.popViewController(animated: true)
        }
        
        collectionPratos.delegate = self
        collectionPratos.dataSource = self
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
        
        collectionPratos.reloadData()
    }
}

extension CardapioViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detalhesController") as! DetalhesViewController
        
        view.prato = RestauranteEscolido?.pratos[indexPath.row]
        
        navigationController?.pushViewController(view, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RestauranteEscolido?.pratos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let prato = RestauranteEscolido?.pratos[indexPath.row] else { return UICollectionViewCell() }
        
        let cell = collectionPratos.dequeueReusableCell(withReuseIdentifier: "celulaPrato", for: indexPath) as! PratoCollectionViewCell
        
        cell.labelNome.text = prato.nome
        cell.imageFoto.image = UIImage(named: "camera.png")
        
        if let fotoData = prato.fotoData {
            if let foto = UIImage(data: fotoData) {
                cell.imageFoto.image = foto
            }
        }
        
        //Configuracoes de Design
        
        //CORTA A IMAGEM PARA QUE SE ENCAIXE NO ESPACO DEFINIDO (NESCESSARIO QUANDO SE USA O CONTENT MODE: "Aspect Fill")
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
}
