//
//  aflmGameViewController.swift
//  AlexExamen
//
//  Created by mac13 on 04/03/21.
//  Copyright © 2021 UTT. All rights reserved.
//

import UIKit

class aflmGameViewController: UIViewController {
    
        @IBOutlet var aflmV4: UIView!
        @IBOutlet var aflmV3: UIView!
        @IBOutlet var aflmV2: UIView!
        @IBOutlet var aflmV1: UIView!
        @IBOutlet var aflmLblWinner: UILabel!
        @IBOutlet var aflmLblScore: UILabel!
        @IBOutlet var aflmLblName: UILabel!
        var timer:Timer!
        var name:String!
        var Score:Int = 0
        var mayor:Int = 0
        var winner:String!
        var index:Int = 0
        var contador:Int = 1
        var level:Int = 1
        var partidas:[aflmPartida] = aflmPartida.all()
        var orden:[Int] = []
    
        override func viewDidLoad() {
            super.viewDidLoad()
            for partidas in self.partidas {
                if partidas.puntaje > self.mayor {
                    self.mayor = partidas.puntaje
                    self.winner = partidas.usuario
                }
            }
            self.aflmLblWinner.text = self.winner
            self.aflmLblName.text = self.name
            self.aflmLblScore.text = String(self.Score)
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            repeticion()
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            let partida = aflmPartida(self.aflmLblName.text!, self.Score)
            partida.add()
            for user in aflmPartida.all(){
                print(user.usuario!)
                print(user.puntaje!)
            }
        }
        
        
        @IBAction func click(_ sender: Any) {
            comprobacion(number: 1)
        }
        @IBAction func click2(_ sender: Any) {
            comprobacion(number: 2)
        }
        @IBAction func click3(_ sender: Any) {
            comprobacion(number: 3)
        }
        @IBAction func click4(_ sender: Any) {
            comprobacion(number: 4)
        }
        
        func changeColor(view:UIView,red:Double, green:Double, blue:Double){
            view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 0.7)
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                view.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
            }
        }
        
        func selectView(election:Int) -> Int{
            switch election {
            case 1:
                changeColor(view: self.aflmV1,red: 1.0, green: 204/255, blue: 2/255)
            case 2:
                changeColor(view: self.aflmV2,red: 1.0, green: 50/255, blue: 48/255)
            case 3:
                changeColor(view: self.aflmV3,red: 2/255, green: 143/255, blue: 0/255)
            case 4:
                changeColor(view: self.aflmV4,red: 4/255, green: 51/255, blue: 255/255)
            default:
                self.alertDefault(with: "No hay nada para ti", andWithMsg: "a")
            }
            return election
        }
        
        func comprobacion(number:Int){
            if index < self.orden.count{
                if self.orden[index] == number{
                    print("si le acertaste")
                    index += 1
                    if index == self.orden.count{
                        self.alertDefault(with: "Ganaste", andWithMsg: "asi es")
                        self.Score += 10
                        index = 0
                        self.orden.removeAll()
                        aflmLblScore.text = String(self.Score)
                        contador += 1
                        //level += 1
                        self.repeticion()
                        return
                    }
                }else{
                    print("No te equivocaste")
                    self.dismiss(animated: true, completion: nil)
                }
            }else{
                print("ya te pasaste carnal")
                /*let partida = aflmPartida(self.aflmLblName.text!, self.Score)
                partida.add()*/
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        func repeticion(){
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }
        @objc func fireTimer(){
            let random = Int.random(in: 1...4)
            self.orden.append(random)
            print(self.selectView(election: random))
            print("Contador: \(contador)")
            print("Index: \(self.orden.count)")
            if self.contador <= self.orden.count{
                print("help")
                timer.invalidate()
            }
        }
        
        func AgregarArreglo(){
            let random = Int.random(in: 1...4)
            self.orden.append(random)
        }
        func delayWithSeconds(_ seconds: Double, completion: @escaping () ->()){
            DispatchQueue.main.asyncAfter(deadline: .now()+seconds){
                completion()
        }
    }
}
