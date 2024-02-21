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


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene{
            let window = UIWindow(windowScene: windowScene)
            
//            let viewController = QuestionViewController(question: "A Questions?", options: ["Options 1", "Options 2"], selection: { print($0) })
            let viewController = ResultsViewController(summary: "You got 1/2 correct", answers: [
                PresentableAnswer(question: "Question?", answer: "Yeah! Yeah!Yeah!Yeah!Yeah!Yeah!Yeah!Yeah!Yeah!Yeah!", wrongAnswer: nil),
                PresentableAnswer(question: "Another Question?", answer: "Hell Yeah!", wrongAnswer: "Hell no")
            ])
            
            _ = viewController.view
//            viewController.tableView.allowsMultipleSelection = false
            window.rootViewController = viewController
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}


}

