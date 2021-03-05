//
//  ViewController.swift
//  AlexExamen
//
//  Created by mac13 on 04/03/21.
//  Copyright © 2021 UTT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var aflmTfPlayerName: UITextField!
    @IBOutlet var aflmBtnPlay: UIButton!
    var partidas:[aflmPartida] = []
    var name:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aflmBtnPlay.layer.cornerRadius = self.aflmBtnPlay.bounds.height/2
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgGame"{
            let controller2 = segue.destination as! aflmGameViewController
            controller2.name = aflmTfPlayerName.text!
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func play(_ sender: UIButton) {
        self.partidas = aflmPartida.all()
        self.name = aflmTfPlayerName.text!
        if !aflmTfPlayerName.text!.isEmpty{
            if existsUser(username: aflmTfPlayerName.text!){
                self.alertDefault(with: "Usuario no disponible", andWithMsg: "El usuario ya existe en el sistema")
                sender.shake()
            }else{
                self.performSegue(withIdentifier: "sgGame", sender: nil)
                self.aflmTfPlayerName.text = ""
            }
        }else{
            self.alertDefault(with: "Campos vacios", andWithMsg: "Rellena los campos por favor")
        }
    }
    
    func existsUser(username:String) -> Bool{
        return getPartidas()?.filter({ $0.usuario == username}).count ?? 0 > 0 ? true : false
    }
    
    func getPartidas() -> [aflmPartida]?{
        do{
            let decoder = JSONDecoder()
            if let data = aflmApp.shared.defaults.object(forKey: "partidas") as? Data{
                return try decoder.decode([aflmPartida].self,from: data)
            }
        }catch{
            print("No fue posible decodificar")
        }
        return nil
    }
}

extension UIViewController{
    func alertDefault(with title:String, andWithMsg description:String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(a) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
}
extension UIView{
    func shake(duration: TimeInterval = 0.5, xValue: CGFloat = 12, yValue: CGFloat = 0){
        self.transform = CGAffineTransform(translationX: xValue, y: yValue)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
