import Foundation

struct GameActivity: Codable {
    let gameName: String
    let amount: Int
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard

    private init() {}

    var totalGames: Int {
        get { defaults.integer(forKey: "totalGames") }
        set { defaults.set(newValue, forKey: "totalGames") }
    }

    func incrementTotalGames() {
        totalGames += 1
    }
    
    // MARK: Coins
    var coins: Int {
        get { defaults.integer(forKey: "coins") }
        set { defaults.set(newValue, forKey: "coins") }
    }

    func addCoins(_ amount: Int) {
        coins += amount
    }

    func removeCoins(_ amount: Int) {
        coins = max(coins - amount, 0)
    }

    // MARK: Wins
    var totalWin: Int {
        get { defaults.integer(forKey: "totalWin") }
        set { defaults.set(newValue, forKey: "totalWin") }
    }

    var maxWin: Int {
        get { defaults.integer(forKey: "maxWin") }
        set { defaults.set(newValue, forKey: "maxWin") }
    }

    var winPercent: Double {
        get { defaults.double(forKey: "winPercent") }
        set { defaults.set(newValue, forKey: "winPercent") }
    }

    // MARK: Last 3 Activities
    var lastActivities: [GameActivity] {
        get {
            if let data = defaults.data(forKey: "lastActivities"),
               let activities = try? JSONDecoder().decode([GameActivity].self, from: data) {
                return activities
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                defaults.set(data, forKey: "lastActivities")
            }
        }
    }

    func addActivity(_ activity: GameActivity) {
        var activities = lastActivities
        activities.append(activity)
        if activities.count > 3 {
            activities.removeFirst(activities.count - 3)
        }
        lastActivities = activities
        
        if activity.amount > 0 {
            totalWin += activity.amount
            
            if activity.amount > maxWin {
                maxWin = activity.amount
            }
        }
        
        if totalGames > 0 {
            let winsCount = activities.filter { $0.amount > 0 }.count
            winPercent = Double(winsCount) / Double(totalGames) * 100
        } else {
            winPercent = 0
        }
    }


    // MARK: Level and Progress
    private let pointsPerLevel = 100

    var level: Int {
        get { defaults.integer(forKey: "level") }
        set { defaults.set(newValue, forKey: "level") }
    }

    var progress: Int {
        get { defaults.integer(forKey: "progress") }
        set {
            let newProgress = max(0, min(newValue, pointsPerLevel))
            defaults.set(newProgress, forKey: "progress")
            if newProgress >= pointsPerLevel {
                level += 1
                defaults.set(0, forKey: "progress")
            }
        }
    }

    func addProgress(_ amount: Int) {
        let currentProgress = progress
        let updatedProgress = currentProgress + amount

        if updatedProgress >= pointsPerLevel {
            level += 1
            progress = updatedProgress - pointsPerLevel
        } else {
            progress = updatedProgress
        }
    }
    
    func resetAll() {
        defaults.removeObject(forKey: "coins")
        defaults.removeObject(forKey: "totalWin")
        defaults.removeObject(forKey: "maxWin")
        defaults.removeObject(forKey: "winPercent")
        defaults.removeObject(forKey: "lastActivities")
        defaults.removeObject(forKey: "level")
        defaults.removeObject(forKey: "progress")
        defaults.removeObject(forKey: "energy")
        defaults.removeObject(forKey: "achievements")
        addCoins(5000)
    }
    
    func setFirstGamePlayed() {
        defaults.set(1, forKey: "firstGame")
    }

    func isFirstGamePlayed() -> Bool {
        return defaults.integer(forKey: "firstGame") == 1
    }
}
