//
//  Pedido.swift
//  Smart Menu
//
//  Created by Vinicius Valente on 28/03/19.
//  Copyright © 2019 Vinicius Valente. All rights reserved.
//

import UIKit

struct Pedido: Codable {
    
    
    var restaurante: String
    var pratos: Array<Prato>
    var mesa: String
    
    init(restaurante: String, pratos: Array<Prato>, mesa: String) {
        self.restaurante = restaurante
        self.pratos = pratos
        self.mesa = mesa
    }
}
