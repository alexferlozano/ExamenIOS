//
//  aflmPartida.swift
//  AlexExamen
//
//  Created by mac13 on 04/03/21.
//  Copyright © 2021 UTT. All rights reserved.
//

import UIKit

class aflmPartida: Codable {
    var usuario:String!
    var puntaje:Int!
    
    init(_ usuario:String, _ puntaje:Int){
        self.usuario = usuario
        self.puntaje = puntaje
    }
    
    func store(){
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(aflmApp.shared.partidas)
            aflmApp.shared.defaults.set(data, forKey: "partidas")
            aflmApp.shared.defaults.synchronize()
        }catch {
            print("Error serialization \(error)")
        }
    }
    
    func add(){
        aflmApp.shared.partidas = aflmPartida.all()
        aflmApp.shared.partidas.append(self)
        self.store()
    }
    
    static func all() -> [aflmPartida]{
        if let data = aflmApp.shared.defaults.object(forKey: "partidas") as? Data {
            let decoder = JSONDecoder()
            guard let partidas = try? decoder.decode([aflmPartida].self, from: data) else { return [aflmPartida]() }
            return partidas
        }
        return [aflmPartida] ()
    }
}
