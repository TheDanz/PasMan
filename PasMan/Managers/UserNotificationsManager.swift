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
    
    func sendNotifications(after days: Int, body: String, uuid: String) {
        
        let date = Calendar.current.date(byAdding: .day, value: days, to: Date())!
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let content = UNMutableNotificationContent()
        content.title = "Password expiration".localized()
        content.body = body
        content.badge = 1
        content.sound = UNNotificationSound.default
 
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: calendarTrigger)
        notificationCenter.add(request)
    }
    
    func deleteNotification(withUUID: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [withUUID])
    }
}
