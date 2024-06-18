import UIKit

enum R {
    enum Colors {
        static let active = UIColor(hexString: "#FFFFFF")
        static let inactive = UIColor(hexString: "#545458")
        
        static let backbar = UIColor(hexString: "#1C1C1D")
        
        static let titleWhite = UIColor(hexString: "#FFFFFF")
    }
    
    enum Strings {
        enum TabBar {
            static func title(for tab: Tabs) -> String {
                switch tab {
                case .overview: return "Overview"
                case .session: return "Session"
                case .progress: return "Progress"
                }
            }
        }
        enum NavBar {
            static let overview = "Overview"
            static let session = "Session"
            static let progress = "Progress"
        }
        
        enum Overview {
            static let overview = "Overview"
        }
        
        enum Session {
            static let navBarStart = "Start   "
            static let navBarPause = "Pause"
            static let navBarFinish = "Finish"
            
            static let elapsedTime =  "Elapsed Time"
            static let remainingTime = "Remaining Time"
            
            static let workoutStats = "Workout stats"
            static let averagePace = "Average pace"
            static let heartRate = "Heart rate"
            static let totalDistance = "Total distance"
            static let totalSteps = "Total steps"
            
            static let stepsCounter = "Steps Counter"
        }
        
        enum Progress {
            static let navBarLeft = "Export"
            static let navBarRight = "Details"
            
            static let dailyPerfomance = "Daily perfomance"
            static let last7Days = "Last 7 days"
            static let monthlyPerformance = "Monthly performance"
            static let last10Months = "Last 10 months"
        }
    }
    
    enum Images {
        enum TabBar {
            static func icon(for tab: Tabs) -> UIImage? {
                switch tab {
                case.overview: return UIImage(named: "overview_tab")
                case.session: return UIImage(named: "session_tab")
                case.progress: return UIImage(named: "progress_tab")
                }
            }
        }
        
        enum Session {
            enum Stats {
                static let averagePace = UIImage(named: "stats_averagePace")
                static let heartRate = UIImage(named: "stats_heartRate")
                static let totalDistance = UIImage(named: "stats_totalDistance")
                static let totalSteps = UIImage(named: "stats_totalSteps")
            }
        }
        
        enum Overview {
            static let checkmarkNotDone = UIImage(named: "checkmark_not_done")
            static let checkmarkDone = UIImage(named: "checkmark_done")
            static let rightArrow = UIImage(named: "right_arrow")

        }
    }
    
    enum Fonts {
        static func helvilticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
}
