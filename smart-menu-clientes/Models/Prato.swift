//
//  Prato.swift
//  Smart Menu
//
//  Created by Vinicius Valente on 19/03/19.
//  Copyright © 2019 Vinicius Valente. All rights reserved.
//

import UIKit

struct Prato: Codable {
    
    var nome: String
    var fotoData: Data?
    var preco: Double
    var descrissao: String
    
    init(nome: String, fotoData: Data, preco: Double, descrissao: String) {
        self.nome = nome
        self.fotoData = fotoData
        self.preco = preco
        self.descrissao = descrissao
    }
    
    init(nome: String, preco: Double, descrissao: String) {
        self.nome = nome
        self.preco = preco
        self.descrissao = descrissao
    }
}

