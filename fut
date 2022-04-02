//
//  ViewController.swift
//  Futbol
//
//  Created by Alvaro Fontalez on 30/3/22.
//
import UIKit

class ViewController: UIViewController {
    
    private var competitions: [Competitions] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        readFile()
        mostrarJsonConsola()
        // Do any additional setup after loading the view.
    }

    private func readFile() {
        if let url = URL(string: "https://raw.githubusercontent.com/zodiacodam/futIOS/main/fut2.json"),
         let data = try? Data(contentsOf: url) {
        let decoder = JSONDecoder()
        if let jsonData = try? decoder.decode(JSONData.self, from: data) {
          self.competitions = jsonData.competitions
//            print(jsonData)
        }
      }
    }
    
    struct JSONData: Decodable {
      let competitions: [Competitions]

    }
    func mostrarJsonConsola() {
        print(competitions)
    }
//SON TODOS STRING YA QUE EL JSON VIENE DE ESTA MANERA
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
}
/*
request.allHTTPHeaderFields = [
    "X-Auth-Token": "ca85682defbf4b57992b9eb3abdef8ce"
]*/
