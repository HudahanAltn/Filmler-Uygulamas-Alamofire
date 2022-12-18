//
//  ViewControllerFilmler.swift
//  Filmler Uygulaması
//
//  Created by Hüdahan Altun on 9.07.2022.
//

import UIKit
import Alamofire
class ViewControllerFilmler: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var filmlerListesi:[Filmler] = [Filmler]()
    
    var kategori:Kategoriler?
    
    override func viewDidLoad() {
        super.viewDidLoad()



        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        let tasarım:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let genislik = self.collectionView.frame.size.width
        
        tasarım.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let hücreGenislikk =  ( genislik - 30 )/2
        
        tasarım.itemSize = CGSize(width: hücreGenislikk, height: hücreGenislikk*1.58)
        
        tasarım.minimumInteritemSpacing = 10
        tasarım.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = tasarım
        
        if let k = kategori{//8) VC den buraya gönderilern kategori nesnesini aldık
           
            if let kid = Int(k.getKategori_id()!){//id ınt dır ama string e çevirmek iiçn if let kullandık
                
                //navitagiton alanında kategori ismi yazdırdık
                navigationItem.title = k.getKategori_ad()
                filmlerKategoriByID(kategori_id: kid)
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexx = sender as! Int
        
        let gidilecekVC = segue.destination as? ViewControllerDetay
        
        gidilecekVC?.film = filmlerListesi[indexx]
    }
    
}


extension ViewControllerFilmler{
    
    func filmlerKategoriByID(kategori_id:Int){
        
        let params:Parameters = ["kategori_id":"\(kategori_id)"]
        
        AF.request("http://kasimadalan.pe.hu/filmler/filmler_by_kategori_id.php",method: .post,parameters: params).response{
            
            
            (response ) in
            
            if let data = response.data{
                
                do{
                    
                    let cevap = try JSONDecoder().decode(FilmCevap.self, from: data)
                    
                    if let gelenSatırVerisi = cevap.filmler{
                        
                        self.filmlerListesi = gelenSatırVerisi
                    }
                        
                    DispatchQueue.main.async {
                        
                        self.collectionView.reloadData()
                    }
                    
                }catch{
                    
                    print(String(describing: error))
                }
            }
            
        }
    }
    
}
extension ViewControllerFilmler:UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return filmlerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let film = filmlerListesi[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmHücre", for: indexPath) as! CollectionViewCellFilmler
        
        cell.filmLabel.text = film.getFilm_ad()!
        cell.fiyatLabel.text = "24,99TL"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(film.getFilm_resim()!)"){
            
            DispatchQueue.global().async {
                
                do{
                    
                    let data = try Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        
                        cell.imageView.image = UIImage(data: data)
                    }
                    
                }catch{
                    
                    print("resim almada hata!")
                    
                }
            }
        }
        cell.imageView.image = UIImage(named:film.getFilm_resim()!)
        
        //cell tasarımı
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        //Protocolü cell'e bağlamak
        cell.hücreProtocol = self
        cell.indexxPAth = indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toFilmlerDetay", sender: indexPath.row)
    }
    
    
    
}


extension ViewControllerFilmler:CollectionViewCellFilmlerProtocol{
    func sepeteEkleProtocol(indexPath: IndexPath) {
        
        print("satın alınan film : \(filmlerListesi[indexPath.row].getFilm_ad()!)")
    }
    
    
    
}
