# Localizer for iOS
A simple text localisation class for iOS.

I created this to be more flexible than the in built localiser. With this file, you don't have to restart your iOS app to update the language. And this code doesn't care your iPhone's language. You can freely have different languages on your app and iPhone.

### Example Code

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
....
  Localizer.setAppleLanguageTo("en")// Optional: set default language to English for the first time,
  Localizer.DoTheSwizzling()
}
```
When you want to change your language in your app, change the language like this.
```swift
Localizer.setAppleLanguageTo("en") // 'en', 'tr', 'jp' etc etc
```
After you change your language, you must set your root view controller to default one, and the app will restart the all UI and update the language.

```swift
// go to root VC and restart all the UI
let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let mainSB = UIStoryboard(name: "YOUR STORY BOARD", bundle: nil)
let rootVC = mainSB.instantiateViewControllerWithIdentifier("YOUR ROOT VC")
appDelegate.window!.rootViewController = rootVC
```

## Notes
- Swift 3
