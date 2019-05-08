//
//  Globals.swift
//  Smart Menu Clientes
//
//  Created by Vinicius Valente on 05/04/19.
//  Copyright © 2019 Vinicius Valente. All rights reserved.
//

import Foundation

//MARK: - Atributos

var RestauranteEscolido: Restaurante?
var ListaDeRestaurantes:  Array<Restaurante>?
var Mesa: String?

//MARK: - Metodos

func recuperaListaGeralDeRestaurantesDoServidor(filtro: String? = nil) {
    
    func completionAPIRestaurantes(listaDeRestaurantes:  Array<Restaurante>) {
        
        if filtro == nil {

            ListaDeRestaurantes = listaDeRestaurantes

            if RestauranteEscolido == nil {
                return
            } else {
                for restaurante in ListaDeRestaurantes ?? [] {
                    if restaurante.id == RestauranteEscolido!.id {
                        RestauranteEscolido = restaurante
                        return
                    }
                }
            }
        }
        
        ListaDeRestaurantes = []
        
        for restaurante in listaDeRestaurantes {
            
            if filtro == nil {
                return
            }
            
            if restaurante.nome.lowercased().contains(filtro!.lowercased()) {
                ListaDeRestaurantes!.append(restaurante)
            }
        }
        
        if RestauranteEscolido == nil {
            return
        }
        
        for restaurante in ListaDeRestaurantes ?? [] {
            if restaurante.id == RestauranteEscolido!.id {
                RestauranteEscolido = restaurante
            }
        }
    }
    
    API.recuperaRestaurantes(completion: completionAPIRestaurantes)
}

