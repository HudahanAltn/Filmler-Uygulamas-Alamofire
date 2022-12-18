//
//  Kategoriler.swift
//  Filmler Uygulaması
//
//  Created by Hüdahan Altun on 9.07.2022.
//

import Foundation


class Kategoriler:Codable{//1 sınfı codable yaptık ve id leri string yaptık
    
    private var kategori_id:String?
    private var kategori_ad:String?
    
    
    init(){
        
        
    }
    init(kategori_id:String,kategori_ad:String){
        
        self.kategori_ad = kategori_ad
        self.kategori_id = kategori_id
        
        
    }
    
    func getKategori_id()->String?{
        
        return kategori_id!
    }
    
    func getKategori_ad()->String?{
        
        return kategori_ad!
    }
}
