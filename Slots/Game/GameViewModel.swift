import SwiftUI

class GameViewModel: ObservableObject {
    let contact = GameModel()
    @Published var board: [[String]] = Array(repeating: Array(repeating: "classic1", count: 5), count: 3)
    @Published var isSpinning = false
    @Published var isStopSpininng = false
    @Published var currentIndex: Int
    @Published var winningPositions: [(row: Int, col: Int)] = []
    @Published var activeLinesCount = 10
    @Published var balance: Int = UserDefaults.standard.integer(forKey: "coin")
    @Published var bet: Int = 50
    @Published var win: Int = 0
    
    var arrayOfImage: [String] {
        switch currentIndex {
        case 0:
            return ["classic1","classic2","classic3","classic4","classic5","classic6","classic7","classic8"]
        case 1:
            return ["neptune1","neptune2","neptune3","neptune4","neptune5","neptune6","neptune7","neptune8"]
        case 2:
            return ["ruby1","ruby2","ruby3","ruby4","ruby5","ruby6","ruby7","ruby8"]
        case 3:
            return ["amethyst1","amethyst2","amethyst3","amethyst4","amethyst5","amethyst6","amethyst7","amethyst8"]
        default:
            return ["classic1","classic2","classic3","classic4","classic5","classic6","classic7","classic8"]
        }
    }
    
    var multipliers: [String: [Int: Int]] {
        switch currentIndex {
        case 0:
            return [
                "classic1": [2: 10, 3: 100, 4: 1000, 5: 5000],
                "classic2": [2: 5, 3: 40, 4: 400, 5: 2000],
                "classic3": [2: 5, 3: 30, 4: 100, 5: 750],
                "classic4": [2: 5, 3: 30, 4: 100, 5: 750],
                "classic5": [3: 5, 4: 40, 5: 250],
                "classic6": [3: 5, 4: 40, 5: 250],
                "classic7": [3: 5, 4: 40, 5: 150],
                "classic8": [3: 5, 4: 40, 5: 150]
            ]
        case 1:
            return [
                "neptune1": [2: 10, 3: 100, 4: 1000, 5: 5000],
                "neptune2": [2: 5, 3: 40, 4: 400, 5: 2000],
                "neptune3": [2: 5, 3: 30, 4: 100, 5: 750],
                "neptune4": [2: 5, 3: 30, 4: 100, 5: 750],
                "neptune5": [3: 5, 4: 40, 5: 250],
                "neptune6": [3: 5, 4: 40, 5: 250],
                "neptune7": [3: 5, 4: 40, 5: 150],
                "neptune8": [3: 5, 4: 40, 5: 150]
            ]
        case 2:
            return [
                "ruby1": [2: 10, 3: 100, 4: 1000, 5: 5000],
                "ruby2": [2: 5, 3: 40, 4: 400, 5: 2000],
                "ruby3": [2: 5, 3: 30, 4: 100, 5: 750],
                "ruby4": [2: 5, 3: 30, 4: 100, 5: 750],
                "ruby5": [3: 5, 4: 40, 5: 250],
                "ruby6": [3: 5, 4: 40, 5: 250],
                "ruby7": [3: 5, 4: 40, 5: 150],
                "ruby8": [3: 5, 4: 40, 5: 150]
            ]
        case 3:
            return [
                "amethyst1": [2: 10, 3: 100, 4: 1000, 5: 5000],
                "amethyst2": [2: 5, 3: 40, 4: 400, 5: 2000],
                "amethyst3": [2: 5, 3: 30, 4: 100, 5: 750],
                "amethyst4": [2: 5, 3: 30, 4: 100, 5: 750],
                "amethyst5": [3: 5, 4: 40, 5: 250],
                "amethyst6": [3: 5, 4: 40, 5: 250],
                "amethyst7": [3: 5, 4: 40, 5: 150],
                "amethyst8": [3: 5, 4: 40, 5: 150]
            ]
        default:
            return [
                "classic1": [2: 10, 3: 100, 4: 1000, 5: 5000],
                "classic2": [2: 5, 3: 40, 4: 400, 5: 2000],
                "classic3": [2: 5, 3: 30, 4: 100, 5: 750],
                "classic4": [2: 5, 3: 30, 4: 100, 5: 750],
                "classic5": [3: 5, 4: 40, 5: 250],
                "classic6": [3: 5, 4: 40, 5: 250],
                "classic7": [3: 5, 4: 40, 5: 150],
                "classic8": [3: 5, 4: 40, 5: 150]
            ]
        }
    }
    
    init(currentIndex: Int) {
        self.currentIndex = currentIndex
        
        for row in 0..<3 {
            for col in 0..<5 {
                self.board[row][col] = self.arrayOfImage.randomElement()!
            }
        }
    }
    
    let allPayLines = [
        [(0,0), (0,1), (0,2), (0,3), (0,4)],
        [(1,0), (1,1), (1,2), (1,3), (1,4)],
        [(2,0), (2,1), (2,2), (2,3), (2,4)],
        [(0,0), (1,1), (2,2), (1,3), (0,4)],
        [(2,0), (1,1), (0,2), (1,3), (2,4)],
        [(1,0), (0,1), (0,2), (0,3), (1,4)],
        [(1,0), (2,1), (2,2), (2,3), (1,4)],
        [(0,0), (0,1), (1,2), (2,3), (2,4)],
        [(2,0), (2,1), (1,2), (0,3), (0,4)],
        [(1,0), (2,1), (1,2), (0,3), (1,4)]
    ]
    
    func spin() {
        isSpinning = true

        balance -= bet
        UserDefaults.standard.set(balance, forKey: "coin")
        isStopSpininng = false

        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            for row in 0..<3 {
                for col in 0..<5 {
                    self.board[row][col] = self.arrayOfImage.randomElement()!
                }
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            timer.invalidate()
            self.isSpinning = false
            self.isStopSpininng = true
            self.checkWin()
        }
    }
    
    func checkWin() {
        winningPositions.removeAll()
        var totalWin = 0
        
        let payLines = Array(allPayLines.prefix(activeLinesCount))
        
        lineLoop: for line in payLines {
            let symbolsOnLine = line.map { board[$0.0][$0.1] }
            
            var currentSymbol = symbolsOnLine[0]
            var currentCount = 1
            
            var lineIsWinning = true
            var lineWin = 0
            
            for i in 1..<symbolsOnLine.count {
                if symbolsOnLine[i] == currentSymbol {
                    currentCount += 1
                } else {
                    if let multipliersForSymbol = multipliers[currentSymbol],
                       let minCount = multipliersForSymbol.keys.min() {
                        if currentCount < minCount {
                            lineIsWinning = false
                            break
                        } else if let multiplier = multipliersForSymbol[currentCount] {
                            lineWin += multiplier * bet * activeLinesCount
                        } else {
                            lineIsWinning = false
                            break
                        }
                    } else {
                        lineIsWinning = false
                        break
                    }
                    currentSymbol = symbolsOnLine[i]
                    currentCount = 1
                }
            }
            
            if lineIsWinning {
                if let multipliersForSymbol = multipliers[currentSymbol],
                   let minCount = multipliersForSymbol.keys.min() {
                    if currentCount < minCount {
                        lineIsWinning = false
                    } else if let multiplier = multipliersForSymbol[currentCount], lineIsWinning {
                        lineWin += multiplier * bet
                    } else {
                        lineIsWinning = false
                    }
                } else {
                    lineIsWinning = false
                }
            }
            
            if lineIsWinning {
                winningPositions.append(contentsOf: line)
                totalWin += lineWin
                break lineLoop
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.win = totalWin
        }
    }
}
