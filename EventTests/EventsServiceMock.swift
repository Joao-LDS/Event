//
//  EventsServiceMock.swift
//  EventTests
//
//  Created by João Luis dos Santos on 18/07/21.
//

import Quick
import Nimble
@testable import Event

class EventsServiceMock: QuickSpec {
    
    override func spec() {
        describe("Event Model") {
            let decoder = JSONDecoder()
            
            context("Parse Events") {
                var data: Data!
                
                beforeEach {
                    let path = Bundle.main.path(forResource: "events", ofType: "json")!
                    let url = URL(fileURLWithPath: path)
                    data = try? Data(contentsOf: url)
                }
                
                it("Many Object") {
                    let event = try? decoder.decode([Event].self, from: data)
                    expect(event).toNot(beNil())
                    expect(event?.count).to(equal(5))
                    expect(event?[0].people.count).to(equal(2))
                    expect(event?[1].id).to(equal("2"))
                    expect(event?[2].title).to(equal("Feira de Troca de Livros"))
                    expect(event?[3].date).to(equal(1534784400))
                }
            }
            
            context("Array Event Model") {
                var data: Data!
                
                beforeEach {
                    let path = Bundle.main.path(forResource: "event", ofType: "json")!
                    let url = URL(fileURLWithPath: path)
                    data = try? Data(contentsOf: url)
                }
                
                it("Many Object") {
                    let event = try? decoder.decode(Event.self, from: data)
                    expect(event).toNot(beNil())
                    
                    expect(event?.people).toNot(beNil())
                    expect(event?.people.first!.name).to(equal("name 1"))
                    expect(event?.people.first!.id).to(equal("1"))
                    expect(event?.people[1].name).to(equal("name 5"))
                    expect(event?.people[1].id).to(equal("5"))
                    
                    expect(event?.date).to(equal(1534784400))
                    
                    expect(event?.description).to(equal("O Patas Dadas estará na Redenção, nesse domingo, com cães para adoção e produtos à venda!\n\nNa ocasião, teremos bottons, bloquinhos e camisetas!\n\nTraga seu Pet, os amigos e o chima, e venha aproveitar esse dia de sol com a gente e com alguns de nossos peludinhos - que estarão prontinhos para ganhar o ♥ de um humano bem legal pra chamar de seu. \n\nAceitaremos todos os tipos de doação:\n- guias e coleiras em bom estado\n- ração (as que mais precisamos no momento são sênior e filhote)\n- roupinhas \n- cobertas \n- remédios dentro do prazo de validade"))
                    
                    expect(event?.image).to(equal("http://lproweb.procempa.com.br/pmpa/prefpoa/seda_news/usu_img/Papel%20de%20Parede.png"))
                    
                    expect(event?.longitude).to(equal(-51.2146267))
                    expect(event?.latitude).to(equal(-30.0392981))
                    
                    expect(event?.price).to(equal(29.99))
                    
                    expect(event?.title).to(equal("Feira de adoção de animais na Redenção"))
                    
                    expect(event?.id).to(equal("1"))
                }
            }
        }
    }
    
}
