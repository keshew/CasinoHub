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

    // MARK: Energy (0 to 100)
    var energy: Int {
        get { defaults.integer(forKey: "energy") }
        set { defaults.set(min(max(newValue, 0), 100), forKey: "energy") }
    }

    func consumeEnergy() {
        energy = max(energy - 1, 0)
    }

    func restoreEnergy(_ amount: Int) {
        energy = min(energy + amount, 100)
    }

    // MARK: Achievements
    var achievements: [Achiev] {
        get {
            if let data = defaults.data(forKey: "achievements"),
               let achievs = try? JSONDecoder().decode([Achiev].self, from: data) {
                return achievs
            }
            // Инициализация стандартного списка ачивок
            let defaultAchievs = [
                Achiev(name: "First Spin", desc: "Spin your first slot machine", goal: 1, currentGoal: 0),
                Achiev(name: "Lucky Winner", desc: "Win 1000 coins in a single spin", goal: 1000, currentGoal: 0),
                Achiev(name: "Speed Player", desc: "Complete 50 spins in one session", goal: 50, currentGoal: 0),
                Achiev(name: "High Roller", desc: "Bet 100 coins or more", goal: 100, currentGoal: 0),
                Achiev(name: "Jackpot Hunter", desc: "Win 10,000 coins in total", goal: 10000, currentGoal: 0),
                Achiev(name: "Dedicated Player", desc: "Log in for 7 consecutive days", goal: 7, currentGoal: 0)
            ]
            saveAchievements(defaultAchievs)
            return defaultAchievs
        }
        set {
            saveAchievements(newValue)
        }
    }

    private func saveAchievements(_ achievs: [Achiev]) {
        if let data = try? JSONEncoder().encode(achievs) {
            defaults.set(data, forKey: "achievements")
        }
    }

    func updateAchievementProgress(name: String, incrementBy amount: Int = 1) {
        var achievs = achievements
        if let index = achievs.firstIndex(where: { $0.name == name }) {
            var achiev = achievs[index]
            achiev.currentGoal = min(achiev.currentGoal + amount, achiev.goal)
            achievs[index] = achiev
            achievements = achievs
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
    }
}
