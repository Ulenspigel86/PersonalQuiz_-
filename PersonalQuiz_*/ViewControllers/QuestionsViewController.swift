//
//  QuestionsViewController.swift
//  PersonalQuiz_*
//
//  Created by Артем Иванов on 28.10.2024.
//

import UIKit

final class QuestionsViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var rangedSlider: UISlider!
    
    // MARK: - Private Properties
    private var questionIndex = 0
    private let questions = Question.getQuestions()
    private var answersChosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        let answerCount = Float(currentAnswers.count - 1)
        rangedSlider.maximumValue = answerCount
        rangedSlider.value = answerCount / 2
    }
    // вновь дабавленный метод 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as? ResultViewController
        resultVC?.answers = answersChosen
    }
    
    // MARK: - IB Actions
    @IBAction func singleQuestionButtonAction(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answersChosen.append(currentAnswer)
        //обновление экрана тоесть это либо это новые вопросы либо переход на другой экран
        nextQuestion()
    }
    
    @IBAction func multipleQuestionButtonAction() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedQuestionButtonAction() {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
}

// MARK: - Private Methods
private extension QuestionsViewController {
    //задача метода обновлять интерфейс
    func updateUI() {
        for stackView in [ singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        //настройка заголовка тоесть текущий этап вопросов
        title = "Вопрос № \(questionIndex + 1)  из \(questions.count)"
        //Получаем текущий  вопрос
        let currentQuestion = questions[questionIndex]
        //отображение самого текущего вопроса
        questionLabel.text = currentQuestion.title
        //рассчет прогресса в прогрессвью
        let totalProgress = Float(questionIndex) / Float(questions.count)
        //Задает значение прогресса в прогресс вью
        questionProgressView.setProgress(totalProgress, animated: true)
        //отображаем текущие ответы
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    
    ///  Метод для выбора категорий
    ///
    ///  Отображение ответов для выбранной категории
    ///
    /// - Parameter type: Определяет категорию ответов
    
    //в этом методе отображаеи ответы вопросы и прочее
    func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single: showSingleStackView(with: currentAnswers)
        case .multiple: showMultipleStackView(with: currentAnswers)
        case .ranged: showRangedStackView(with: currentAnswers)
        }
    }
    // Показываем кнопки
    func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden = false
        //сопоставление кнопок и ответов
        for (button, answer) in zip(singleButtons,answers)  {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false 
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}

