import UserNotifications

final class UserNotificationsManager {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            
            guard success else { return }
            self.notificationCenter.getNotificationSettings { settings in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
    }
    
    func sendNotifications(on date: DateComponents) {
        
        let content = UNMutableNotificationContent()
        content.title = "First notification"
        content.body = "My first notification"
        content.sound = UNNotificationSound.default
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: calendarTrigger)
        
        notificationCenter.add(request)
    }
}
