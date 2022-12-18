//
//  ViewController.swift
//  Filmler Uygulaması
//
//  Created by Hüdahan Altun on 9.07.2022.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var kategorilerListesi:[Kategoriler] = [Kategoriler] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        tableView.delegate = self
        tableView.dataSource = self
        
        tumKategorileriAl()
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//6)bir sonraki sayfaya geçiş için bu metodu yazdık böylece ilgili kategoriye göre ilgili filmler gösterilir.
        
        
        let indexx = sender as? Int
        
        let gidilecekVC = segue.destination as! ViewControllerFilmler
        
        gidilecekVC.kategori = kategorilerListesi[indexx!]
        
    }

}

extension ViewController{
    
    func tumKategorileriAl(){
      
        AF.request("http://kasimadalan.pe.hu/filmler/tum_kategoriler.php",method:.get).response{
            
            (response) in
            
            
            if let data = response.data{
                
                do{
                    
                    let cevap = try JSONDecoder().decode(kategoriCevap.self, from: data)
                    
                    if let gelenKategoriListesi = cevap.kategoriler{
                        
                        self.kategorilerListesi = gelenKategoriListesi
                    }
                    
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                }catch{
                    
                    print(error.localizedDescription)
                }
            }
        }
   }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategorilerListesi.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let kategori = kategorilerListesi[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kategoriHucre",for:indexPath) as! TableViewCellKategori
        
        cell.kategoriLabel.text = kategori.getKategori_ad()!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toFilmler", sender: indexPath.row)
    }
}

