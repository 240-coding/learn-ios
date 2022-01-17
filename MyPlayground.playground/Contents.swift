import UIKit
import Foundation

protocol Drivable {}
protocol Stoppable {}

// Drivable & Stoppable : 두 프로토콜 결합
func create<T: Drivable & Stoppable>(car: T) {
    
}
class BMW: Drivable, Stoppable {
    
}
class Fruit: Codable {
}
