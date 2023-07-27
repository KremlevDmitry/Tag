//
//  Game.swift
//  Tag
//
//  Created by Дмитрий Кремлев on 13.07.2023.
//

import UIKit

public class Game {
    
    public var numbers: [Int?] = []
    private var winNumbers: [Int?]
    
    public init() {
        winNumbers = Array(1...15)
        winNumbers.append(nil)
    }
    
    public func start() {
        numbers = winNumbers
        
        numbers.shuffle()
    }
    
    public func click(index: Int) {
        let clickPosition = getPosition(index: index)
        let nilIndex = numbers.firstIndex(of: nil)!
        let nilPosition = getPosition(index: nilIndex)
        
        if (abs(clickPosition.x - nilPosition.x) == 1 && clickPosition.y == nilPosition.y) ||
            (abs(clickPosition.y - nilPosition.y) == 1 && clickPosition.x == nilPosition.x) {
            numbers[nilIndex] = numbers[index]
            numbers[index] = nil
        } else if clickPosition.x == nilPosition.x {
            let x = clickPosition.x
            let sign = (clickPosition.y - nilPosition.y) < 0 ? -1 : 1
            
            if (sign == 1) {
                for y in nilPosition.y..<clickPosition.y {
                    numbers[getIndex(x, y)] = numbers[getIndex(x, y + 1)]
                }
            } else {
                for y in ((clickPosition.y + 1)...nilPosition.y).reversed() {
                    numbers[getIndex(x, y)] = numbers[getIndex(x, y - 1)]
                }
            }
            numbers[index] = nil
        } else if clickPosition.y == nilPosition.y {
            let y = clickPosition.y
            let sign = (clickPosition.x - nilPosition.x) < 0 ? -1 : 1
            
            if (sign == 1) {
                for x in nilPosition.x..<clickPosition.x {
                    numbers[getIndex(x, y)] = numbers[getIndex(x + 1, y)]
                }
            } else {
                for x in ((clickPosition.x + 1)...nilPosition.x).reversed() {
                    numbers[getIndex(x, y)] = numbers[getIndex(x - 1, y)]
                }
            }
            numbers[index] = nil
        }
    }
    
    public func checkWin() -> Bool {
        return numbers == winNumbers
    }
    
    
    private func getPosition(index: Int) -> (x: Int, y: Int) {
        return (index % 4, index / 4)
    }
    
    private func getIndex(_ position: (x: Int, y: Int)) -> Int {
        return getIndex(position.x, position.y)
    }
    private func getIndex(_ x: Int, _ y: Int) -> Int {
        return y * 4 + x
    }
}
