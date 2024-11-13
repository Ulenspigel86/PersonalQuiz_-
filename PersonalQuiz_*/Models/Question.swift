//
//  Question.swift
//  PersonalQuiz_*
//
//  Created by Артем Иванов on 29.10.2024.
//


struct Question {
    let title: String
    let type: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] { // static - позволяет вызывать данные этого метода в других классах
        [
            Question(
                title: "Какую пищу Вы предрочитаете?",
                type: .single,
                answers: [
                    Answer(title: "Cтейк", animal: .dog),
                    Answer(title: "Рыба", animal: .cat),
                    Answer(title: "Морковь", animal: .rabbit),
                    Answer(title: "Кукуруза", animal: .turtle)
                ]
            ),
            Question(
                title: "Что Вам нравиться больше?",
                type: .multiple,
                answers: [
                    Answer(title: "Плавать", animal: .dog),
                    Answer(title: "Спать", animal: .cat),
                    Answer(title: "Обниматься", animal: .rabbit),
                    Answer(title: "Есть", animal: .turtle)
                ]
            ),
            Question(
                title: "Любите ли Вы поездки на машине?",
                type: .ranged,
                answers: [
                    Answer(title: "Ненавижу", animal: .cat),
                    Answer(title: "Нервиничаю", animal: .rabbit),
                    Answer(title: "Не замечаю", animal: .turtle),
                    Answer(title: "Обожаю", animal: .dog)
                ]
            )
        ]
    }
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    let title: String
    let animal: Animal
}

enum Animal: Character {
    case cat = "🐱"
    case dog = "🐶"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            "Вам нравиться быть с друзьями. Вы окружаете себя людьми, которые Вам нравяться и всегда готовы помочь."
        case .cat:
             "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
        case .rabbit:
             "Вам норавиться все мягкое. Вы здоровы и полны энергии."
        case .turtle:
             "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на больших дистанциях."
        }
    }
}


