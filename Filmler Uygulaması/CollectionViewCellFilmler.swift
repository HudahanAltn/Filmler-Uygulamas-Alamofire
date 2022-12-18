//
//  CollectionViewCellFilmler.swift
//  Filmler Uygulaması
//
//  Created by Hüdahan Altun on 9.07.2022.
//

import UIKit


protocol CollectionViewCellFilmlerProtocol{
    
    func sepeteEkleProtocol(indexPath:IndexPath)
}

class CollectionViewCellFilmler: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var filmLabel: UILabel!
    
    
    @IBOutlet weak var fiyatLabel: UILabel!
    
    
    var hücreProtocol:CollectionViewCellFilmlerProtocol?
    var indexxPAth:IndexPath?
    
    @IBAction func satınAl(_ sender: Any) {
        
        hücreProtocol?.sepeteEkleProtocol(indexPath: indexxPAth!)
    }
    
    
}
