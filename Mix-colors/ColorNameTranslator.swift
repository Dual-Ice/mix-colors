//
//  ColorNameTranslator.swift
//  Mix-colors
//
//  Created by  Maksim Stogniy on 27.05.2024.
//

import Foundation

final class ColorNameTranslator {
    private let colorTranslations: [String: String] = [
        "red": "красный",
        "orange": "оранжевый",
        "yellow": "желтый",
        "green": "зеленый",
        "blue": "синий",
        "purple": "фиолетовый",
        "pink": "розовый",
        "brown": "коричневый",
        "black": "черный",
        "white": "белый",
        "gray": "серый",
        "silver": "серебряный",
        "gold": "золотой",
        "cyan": "голубой",
        "magenta": "пурпурный",
        "violet": "фиолетовый",
        "lime": "лаймовый",
        "olive": "оливковый",
        "teal": "черно-зеленый",
        "maroon": "темно-красный",
        "navy": "темно-синий",
        "aquamarine": "аквамариновый",
        "coral": "коралловый",
        "fuchsia": "фуксия",
    ]
    
    private let saturationTranslations: [String: String] = [
        "dark": "темный",
        "light": "светлый",
        "pale": "бледный",
        "deep": "глубокий",
        "bright": "яркий",
        "vibrant": "яркий",
        "vivid": "живой",
        "faint": "слабый",
        "intense": "интенсивный",
        "muted": "пастельный",
        "neon": "неоновый",
    ]
    
    private let shadeTranslations: [String: String] = [
        "grayish": "сероватый",
        "brownish": "коричневатый",
        "bluish": "голубоватый",
        "greenish": "зеленоватый",
        "reddish": "красноватый",
        "yellowish": "желтоватый",
        "pinkish": "розоватый",
        "purplish": "фиолетоватый",
        "orangish": "оранжеватый",
        "blueish": "синеватый",
    ]
    
    private func translateWord(_ word: String, category: String) -> String? {
        switch category {
            case "color":
                return colorTranslations[word]
            case "saturation":
                return saturationTranslations[word]
            case "shade":
                return shadeTranslations[word]
            default:
                return nil
        }
    }
    
    func translateString(_ string: String) -> String {
        let words = string.components(separatedBy: " ")
        var translatedWords = [String]()
        for word in words {
            if let translatedWord = translateWord(word, category: "shade") {
                translatedWords.append(translatedWord)
            } else if let translatedWord = translateWord(word, category: "saturation") {
                translatedWords.append(translatedWord)
            } else if let translatedWord = translateWord(word, category: "color") {
                translatedWords.append(translatedWord)
            } else {
                translatedWords.append(word)
            }
        }
        return translatedWords.joined(separator: " ")
    }
}
