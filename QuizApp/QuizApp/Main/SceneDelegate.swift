//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Amin faruq on 13/02/24.
//

import UIKit
import QuizEngine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var quiz: Quiz?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene{
            let window = UIWindow(windowScene: windowScene)
            
            let question1 = Question.singleAnswer("What's Mike's nationality?")
            let question2 = Question.multipleAnswer("What's are Caio's nationalities?")

            let questions = [question1, question2]
            
            let option1 = "Canadian"
            let option2 = "American"
            let option3 = "Greek"
            let options1 = [option1, option2, option3]
            
            let option4 = "Portuguese"
            let option5 = "American"
            let option6 = "Brazilian"
            let options2 = [option4, option5, option6]
            
            let correctAnswers = [(question1, [option3]), (question2, [option4, option6])]
            let options = [question1: options1, question2: options2]
            
            let navigationController = UINavigationController()
            let factory = iOSViewControllerFactory(
                options: options,
                correctAnswers: correctAnswers
            )
            let router = NavigationControllerRouter(
                navigationController: navigationController,
                factory: factory
            )
            
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
            
            quiz = Quiz.start(questions: questions, delegate: router)

        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

