//
//  ViewController.swift
//  itineshary
//
//  Created by Karynn Elio on 1/16/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bg = BackgroundGradient()
        bg.createGradient(view: view, backgroundView: backgroundView)
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        
    }

}

