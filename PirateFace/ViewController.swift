//
//  ViewController.swift
//  PirateFace
//
//  Created by movil6 on 04/11/16.
//  Copyright © 2016 movil6. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtUsuario: SexyTextField!
    @IBOutlet weak var txtPassword: SexyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        txtUsuario.delegate = self
        txtPassword.delegate = self
        
        FIRMessaging.messaging().subscribe(toTopic: "\topics\news")
        
        navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }


    @IBAction func emailBtnPressed(_ sender: LoginButton) {
        
        if let email = txtUsuario.text, let pwd = txtPassword.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { user, error in
                
                if error != nil, let err = error as? NSError {
                    print("Ocurrió un error al ingresar con Firebase")
                    
                    if err.code == ERROR_PASSWORD_NOT_LONG {
                        print("Favor de ingresar un password de más de 6 caracteres")
                    } else if err.code == ERROR_ACCOUNT_ALREADY_USED {
                        print("La cuenta de correo ya está siendo utilizada")
                        
                        FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { user, error in
                            
                            if error != nil , let err = error as? NSError {
                                print(err)
                                if err.code == ERROR_INVALID_PASSWORD {
                                    print("El password ingresado no es válido")
                                } else {
                                    //Ir al siguiente VC.
                                    print("Login Email exitoso")
                                }
                            }
                        })
                    }
                } else {
                    print("Usuario: \(user?.displayName)")
                }
            })
        } else {
            print("Favor de introducir su usuario y password")
        }
    }
    @IBAction func faceBookBtnPressed(_ sender: UIButton) {
        
        let loginManager = FBSDKLoginManager()
        
        loginManager.logIn(withReadPermissions: ["email"], from: self) { result, error in
            
            /*if let user = result, user.isCancelled {
                print("El usuario ha cancelado el Login por Facebook")
            }*/
            if error != nil {
                print("No se pudo conectar con Facebook")
            } else if result?.isCancelled == true {
                print("El usuario ha cancelado el login con Facebook")
            } else {
                print("Login exitoso con Facebook")
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential: credential)
            }
        }
    }

    func firebaseAuth(credential: FIRAuthCredential) {
        
        FIRAuth.auth()?.signIn(with: credential, completion: { user, error in
            
            if error != nil {
                print("No se pudo autenticar con Firebase: Error: \(error.debugDescription)")
            } else {
                print("Se autenticó con éxito con Firebase")
            }
        })
    }
}

