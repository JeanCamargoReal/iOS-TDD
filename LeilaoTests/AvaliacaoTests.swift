//
//  AvaliacaoTests.swift
//  LeilaoTests
//
//  Created by Jean Camargo on 13/01/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class AvaliacaoTests: XCTestCase {
    
    var leiloeiro:Avaliador!
    private var joao:Usuario!
    private var maria:Usuario!
    private var jose:Usuario!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        leiloeiro = Avaliador()
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testDeveEntenderLancesEmOrdemCrescente() {
        
        // Cenario
        
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(maria, 250.0))
        leilao.propoe(lance: Lance(joao, 300.0))
        leilao.propoe(lance: Lance(jose, 400.0))
        
        // Acao
        
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        
        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
        
    }
    
    func testeDeveEntenderLeilaoComApenasUmLance() {
        
        // Cenario
        
        let leilao = Leilao(descricao: "Playstation 4")
        leilao.propoe(lance: Lance(joao, 1000.0))
        
        // Acao
        
        try? leiloeiro.avalia(leilao: leilao)
        
        // Validacao
        
        XCTAssertEqual(1000.0, leiloeiro.menorLance())
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }
    
    func testDeveEncontrarOsTresMaioresLances() {

        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
            .lance(joao, 300.0)
            .lance(maria, 400.0)
            .lance(joao, 500.0)
            .lance(maria, 600.0).constroi()
        
        try? leiloeiro.avalia(leilao: leilao)
        
        let listaLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaLances.count)
        XCTAssertEqual(600.0, listaLances[0].valor)
        XCTAssertEqual(500.0, listaLances[1].valor)
        XCTAssertEqual(400.0, listaLances[2].valor)
    }
    
    func testeDeveIgnorarLeilaoSemNenhumLance() {
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4").constroi()
                
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Não é possível avaliar Leilao sem lances") { (error) in
            print(error.localizedDescription)
        }
    }

}
