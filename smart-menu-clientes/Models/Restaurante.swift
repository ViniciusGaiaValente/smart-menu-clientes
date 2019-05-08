//
//  a.swift
//  Smart Menu
//
//  Created by Vinicius Valente on 19/03/19.
//  Copyright © 2019 Vinicius Valente. All rights reserved.
//


import UIKit

struct Restaurante: Codable {
    
    var id: Int?
    var nome: String
    var senha: String
    var fotoData: Data?
    var pratos: [Prato] = []
    var pedidos: [Pedido] = []
    
    init(nome: String, senha: String) {
        self.nome = nome
        self.senha = senha
    }
    
    init(nome: String, senha: String, fotoData: Data) {
        self.nome = nome
        self.senha = senha
        self.fotoData = fotoData
    }
}
