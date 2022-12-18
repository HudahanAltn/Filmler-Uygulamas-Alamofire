//
//  Filmler.swift
//  Filmler Uygulaması
//
//  Created by Hüdahan Altun on 10.07.2022.
//

import Foundation


class Filmler:Codable{
//4)sınfıı codable yaptık ve id leri stirng yaptık
    private var film_id:String?
    private var film_ad:String?
    private var film_yil:String?
    private var film_resim:String?
    private var yonetmen:Yönetmenler?
    private var kategori:Kategoriler?
    
    
    init(film_id:String,film_ad:String,film_yil:String,film_resim:String,yonetmen:Yönetmenler,kategori:Kategoriler){
        
        self.film_id = film_id
        self.film_ad = film_ad
        self.film_yil = film_yil
        self.film_resim = film_resim
        self.kategori = kategori
        self.yonetmen = yonetmen
    }
    
    func getFilm_id()->String?{
        
        return film_id!
    }
    
    func getFilm_ad()->String?{
        
        return film_ad!
    }
    
    func getFilm_yil()->String?{
        
        return film_yil!
    }
    
    func getFilm_resim()->String?{
        
        return film_resim!
    }
    
    func getYonetmen()->Yönetmenler?{
        
        return yonetmen!
        
    }
    
    func getKategori()->Kategoriler?{
        
        return kategori!
    }
}
