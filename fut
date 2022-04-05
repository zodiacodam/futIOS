//
//  ViewController.swift
//  Futbol
//
//  Created by Alvaro Fontalez on 30/3/22.
//
import UIKit

class ViewController: UIViewController {
    
    private var competitions: [Competitions] = []
    private var competition: [Competition] = []
    private var standings: [Standings] = []

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
//        readFile2()
        readFile()
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            self.mostrar()
        }

    }

    private func readFile() {
        let url = URL(string: "http://api.football-data.org/v2/competitions/2014/standings")
 
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.addValue("ca85682defbf4b57992b9eb3abdef8ce", forHTTPHeaderField: "X-Auth-Token")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
                         
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {return}
            do{
                if let jsonData = try? JSONDecoder().decode(JSONData.self, from: data){
//                    self.standings = jsonData.standings
                    print("👍🏻 ","Leyendo el array........", jsonData) // MOSTRAR POR CONSOLA
                }
            }
        }
        task.resume()
}
  
    private func readFile2() {
        let url = URL(string: "http://api.football-data.org/v2/competitions")
 
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.addValue("ca85682defbf4b57992b9eb3abdef8ce", forHTTPHeaderField: "X-Auth-Token")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
                         
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {return}
            do{
                if let jsonData = try? JSONDecoder().decode(JSONData2.self, from: data){
                    self.competitions = jsonData.competitions
                    print("🔥 ","Leyendo el array de Prueba........", jsonData) // MOSTRAR POR CONSOLA
                }
            }
        }
        task.resume()
}
    
    struct JSONData: Decodable {
        let competition: [Competition]
        let season: [Season]
        let standings: [Standings]
}
    
    struct JSONData2: Decodable {
        let competitions: [Competitions]
}
// SON DEL TIPO DEL QUE VIENE EN EL JSO
//----------------------------------------------------------------------------------------------
    struct Standings: Decodable {
        let stage: String?
        let type: String?
        let group: String?
        let table: Table?
            struct Table: Decodable {
                let position: Int?
                let team: Team?
                    struct Team: Decodable {
                                let id: Int?
                                let name: String?
                                let crestUrl: String?
                    }
                let playedGames: Int?
                let form: Int?
                let won: Int?
                let draw: Int?
                let lost: Int?
                let points: Int?
                let goalsFor: Int?
                let goalsAgainst: Int?
                let goalDifference: Int?
            }
    }
    struct Competition: Decodable {
      let id: Int?
      let area: Area?
        struct Area: Decodable{
            let id: Int?
            let name: String?
        }
        let name: String?
        let code: String?
        let plan : String?
        let lastUpdated: String?
      }
    struct Season: Decodable {
        let id: Int?
        let startDate: String?
        let endDate: String?
        let currentMatchday: Int?
        let winner: String?
    }
//----------------------------------------------------------------------------------------------
    struct Competitions: Decodable {
      let id: Int?
      let area: Area?
        struct Area: Decodable{
            let id: Int?
            let name: String?
            let countryCode: String?
            let ensignUrl: String?
        }
      let name: String?
      let code: String?
      let emblemUrl: String?
      let plan : String?
      let currentSeason: CurrentSeason?
        struct CurrentSeason: Decodable{
            let id: Int?
            let startDate: String?
            let endDate: String?
            let currentMatchday: Int?
            let winner: Winner?
                struct Winner: Decodable{
                    let id: Int?
                    let name: String?
                    let shortName: String?
                    let tla: String?
                    let crestUrl: String?
                }
        }
      let numberOfAvailableSeasons: Int?
      let lastUpdated: String?
    }
    
    /*
       func mostrar(){
           print("Buscando en el array........")
           for competitio in competition {
               if (competitions.name == "Premier Liha"){
                   self.label.text = competitions.code
               }
           }
       }*/
}

