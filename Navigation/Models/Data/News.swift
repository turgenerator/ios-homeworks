//
//  News.swift
//  Navigation
//
//  Created by Nikita Turgenev on 25.03.2022.
//

import Foundation

struct News: Decodable { // Создаем структуру Post

    struct Article: Decodable  {
        var author: String
        var description: String
        var image: String
        var likes: String
        var views: String 

        enum CodingKeys: String, CodingKey {
            case author, description, image, likes, views
        }
    }

    let articles: [Article] // массив статей
}
