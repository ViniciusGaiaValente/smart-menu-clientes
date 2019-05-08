//
//  APIRestaurantes.swift
//  Smart Menu
//
//  Created by Vinicius Valente on 20/03/19.
//  Copyright © 2019 Vinicius Valente. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API: NSObject {

    //MARK: - Inicializadores

    private override init() {
        super.init()
    }

    //MARK: - Meotodos

    static func recuperaRestaurantes(completion: @escaping ([Restaurante]) -> Void) {

        Alamofire.request("http://localhost:3000/restaurantes", method: .get).responseJSON
            { (response) in

                switch response.result {

                case .success(let value):
                    
                    guard let jsonRestaurantes = JSON(value).array else { return }
                    var listaDeRestaurantes: [Restaurante] = []
                    
                    for json in jsonRestaurantes {
                        
                        do {
                            let restaurante = try JSONDecoder().decode(Restaurante.self, from: json.rawData())
                            listaDeRestaurantes.append(restaurante)
                            
                            if listaDeRestaurantes.count > 0 {
                                completion(listaDeRestaurantes)
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                    
                    break

                case .failure(let error):

                    print(error.localizedDescription)

                    break
            }
        }
    }
    
    static func addPedido(pedido: Pedido) {
        
        recuperaListaGeralDeRestaurantesDoServidor()
        
        if RestauranteEscolido == nil { print("erro1"); return }
        
        if RestauranteEscolido!.id == nil { print("erro2"); return }
        
        RestauranteEscolido!.pedidos.append(pedido)
        
//        var i = 0
//
//        for pedidoPercorrido in RestauranteEscolido!.pedidos{
//
//            if pedido.mesa == pedidoPercorrido.mesa {
//
//                for prato in pedidoPercorrido.pratos {
//
//                    RestauranteEscolido!.pedidos[i].pratos.append(prato)
//                }
//            } else {
//                RestauranteEscolido!.pedidos.append(pedido)
//            }
//            i += 1
//        }
//
//        if RestauranteEscolido!.pedidos.count == 0 {
//            RestauranteEscolido!.pedidos.append(pedido)
//        }
        
        
        
        guard let url = URL(string: "http://localhost:3000/restaurantes/\(RestauranteEscolido!.id!)") else { print("URL NAO ENCONTRADA"); return }
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "PUT"
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            requisicao.httpBody = try JSONEncoder().encode(RestauranteEscolido!)
            Alamofire.request(requisicao)
        } catch {
            print(error)
        }
    }
    
    static func apagaPedido(mesa: String) {
        
        recuperaListaGeralDeRestaurantesDoServidor()
        
        if RestauranteEscolido == nil { return }
        
        if RestauranteEscolido!.id == nil { return }
        
        var i = 0
        for pedido in RestauranteEscolido!.pedidos{
            if pedido.mesa == mesa {
                RestauranteEscolido!.pedidos.remove(at: i)
                break
            }
            i += 1
        }
        
        guard let url = URL(string: "http://localhost:3000/restaurantes/\(RestauranteEscolido!.id!)") else { print("URL NAO ENCONTRADA"); return }
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "PUT"
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            requisicao.httpBody = try JSONEncoder().encode(RestauranteEscolido!)
            Alamofire.request(requisicao)
        } catch {
            print(error)
        }
    }
}
