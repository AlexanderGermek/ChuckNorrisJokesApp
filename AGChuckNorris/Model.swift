//
//  Model.swift
//  AGChuckNorris
//
//  Created by Admin on 24.01.2021.
//  Copyright © 2021 AlexGermek. All rights reserved.
//

import Foundation
    
    // 1. Для получения макс кол-ва шуток:
    struct MaxJokesCount: Decodable {
            let type: String
            let value: Int
    }


    // 2. Для получения шуток:
    struct RandomJokes: Decodable{
        let type: String
        let value: [Joke]
    }

    struct Joke: Decodable{
        let id: Int
        let joke: String
    }

    
