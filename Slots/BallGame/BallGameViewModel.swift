import SwiftUI

class BallGameViewModel: ObservableObject {
    func createGameScene(gameData: GameData) -> GameSpriteKit {
        let scene = GameSpriteKit()
        scene.game  = gameData
        return scene
    }
}
