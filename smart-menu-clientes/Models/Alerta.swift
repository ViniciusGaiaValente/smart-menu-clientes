//
//  Alerta.swift
//  CoreDataModel-2.0
//
//  Created by Vinicius Valente on 12/02/2019.
//  Copyright © 2019 Vinicius Valente. All rights reserved.
//

import UIKit
import Foundation

class Alerta: NSObject {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func mostrarMensagem(titulo: String = "ERRO", mensagem: String = "erro inesperado") { // MOSTRA UM ALERTA COM UMA MENSAGEM DE ERRO, O TITULO E MENSAGEM TEM VALORES PADRAO QUE PODEM SER ALTERADOS
        
        let menuDeAlerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertController.Style.alert)
        
        let cancelar = UIAlertAction(title: "CANCELAR", style: UIAlertAction.Style.cancel, handler: nil)
        
        menuDeAlerta.addAction(cancelar)
        controller.present(menuDeAlerta, animated: true)
    }
    
    func mostrarAlertaComOk(okAction: @escaping (UIAlertAction) -> Void, titulo: String = "ERRO", mensagem: String = "erro inesperado") { // MOSTRA UM ALERTA COM UMA MENSAGEM DE ERRO, O TITULO E MENSAGEM TEM VALORES PADRAO QUE PODEM SER ALTERADOS
        
        let menuDeAlerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertController.Style.alert)
        
        let funcaoOk = UIAlertAction(title: "OK", style: .default, handler: okAction)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        menuDeAlerta.addAction(funcaoOk)
        menuDeAlerta.addAction(cancelar)
        controller.present(menuDeAlerta, animated: true)
    }
    
    func mostrarMenuDeUmaOpcao(titulo: String = "Atençao", mensagem: String = "erro inesperado", opcao1Nome: String, opcao1Acao: @escaping (UIAlertAction) -> Void) { // MOSTRA UM ALERTA COM UMA MENSAGEM DE ERRO, O TITULO E MENSAGEM TEM VALORES PADRAO QUE PODEM SER ALTERADOS
        
        let menuDeOpcoes = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertController.Style.actionSheet)
        
        let opcao1 = UIAlertAction(title: opcao1Nome, style: .default, handler: opcao1Acao)
        
        let cancel = UIAlertAction(title: "CANCELAR", style: .cancel, handler: nil)
        
        menuDeOpcoes.addAction(opcao1)
        menuDeOpcoes.addAction(cancel)
        
        controller.present(menuDeOpcoes, animated: true)
    }
    
    @objc func mostrarMenuDeDuasOpcoes(titulo: String = "Atençao", mensagem: String = "escolha uma opção", opcao1Nome: String, opcao2Nome: String, opcao1Acao: @escaping (UIAlertAction) -> Void, opcao2Acao: @escaping (UIAlertAction) -> Void) { // MOSTRA UM ACTION SHEET COM 2 BOTOES, O TITULO E MENSAGEM TEM VALORES PADRAO QUE PODEM SER ALTERADOS, CADA BOTAO RECEBE OBRIGAOTIRAMENTE UM TITULO E UMA ACAO, CADA UMA DESSA ACOES RECEBIDAS PRECISA RECEBER OBRIGATORIAMENTE UM PARAMENTRO "action" DO TIPO "UIAlertAction", ESSE PARAMETRO PRECISA SER PASSADO MESMO QUE NAO SEJA UTILIZADO
        
        let menuDeOpcoes = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertController.Style.actionSheet)
        
        let opcao1 = UIAlertAction(title: opcao1Nome, style: .default, handler: opcao1Acao)
        
        let opcao2 = UIAlertAction(title: opcao2Nome, style: .default, handler: opcao2Acao)
        
        let cancel = UIAlertAction(title: "CANCELAR", style: .cancel, handler: nil)
        
        menuDeOpcoes.addAction(opcao1)
        menuDeOpcoes.addAction(opcao2)
        menuDeOpcoes.addAction(cancel)
        
        controller.present(menuDeOpcoes, animated: true, completion: nil)
    }
    
    @objc func mostrarMenuDeTresOpcoes(titulo: String = "Atençao", mensagem: String = "escolha uma opção", opcao1Nome: String, opcao2Nome: String, opcao3Nome: String, opcao1Acao: @escaping (UIAlertAction) -> Void, opcao2Acao: @escaping (UIAlertAction) -> Void, opcao3Acao: @escaping (UIAlertAction) -> Void) { // MOSTRA UM ACTION SHEET COM 2 BOTOES, O TITULO E MENSAGEM TEM VALORES PADRAO QUE PODEM SER ALTERADOS, CADA BOTAO RECEBE OBRIGAOTIRAMENTE UM TITULO E UMA ACAO, CADA UMA DESSA ACOES RECEBIDAS PRECISA RECEBER OBRIGATORIAMENTE UM PARAMENTRO "action" DO TIPO "UIAlertAction", ESSE PARAMETRO PRECISA SER PASSADO MESMO QUE NAO SEJA UTILIZADO
        
        let menuDeOpcoes = UIAlertController(title: titulo, message: mensagem, preferredStyle: UIAlertController.Style.actionSheet)
        
        let opcao1 = UIAlertAction(title: opcao1Nome, style: .default, handler: opcao1Acao)
        
        let opcao2 = UIAlertAction(title: opcao2Nome, style: .default, handler: opcao2Acao)
        
        let opcao3 = UIAlertAction(title: opcao3Nome, style: .default, handler: opcao3Acao)
        
        let cancel = UIAlertAction(title: "CANCELAR", style: .cancel, handler: nil)
        
        menuDeOpcoes.addAction(opcao1)
        menuDeOpcoes.addAction(opcao2)
        menuDeOpcoes.addAction(opcao3)
        menuDeOpcoes.addAction(cancel)
        
        controller.present(menuDeOpcoes, animated: true, completion: nil)
    }
}

