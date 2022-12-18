//
//  Yönetmenler.swift
//  Filmler Uygulaması
//
//  Created by Hüdahan Altun on 10.07.2022.
//

import Foundation


class Yönetmenler:Codable{//3) sınıfı codable yaptık ve idleri stirng yaptık
    
    private var yonetmen_id:String?
    private var yonetmen_ad:String?
    
    init(){
        
        
    }
    init(yonetmen_id:String,yonetmen_ad:String){
        
        self.yonetmen_id = yonetmen_id
        self.yonetmen_ad = yonetmen_ad
        
    }
    
    func getYönetmen_id()->String?{
        
        return yonetmen_id!
    }
    
    func getYönetmen_ad()->String?{
        
        return yonetmen_ad!
    }
}
