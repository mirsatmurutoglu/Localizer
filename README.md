# Localizer for iOS
A simple text localisation class for iOS.

I created this to be more flexible than the in built localiser. With this file, you don't have to restart your iOS app to update the language.
### Example Code

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
....
  // set default language to English for the first time,
  Localizer.setAppleLAnguageTo("en")
  Localizer.DoTheSwizzling()
}
```
When you want to change your language in your app, set the language that you want to.
```swift
Localizer.setAppleLAnguageTo("en") // 'en', 'tr', 'jp' etc etc
```
After you set your language, you must set your root view controller to default one, and the app will restart the all UI

```swift
// go to root VC and restart all the UI
let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
let mainSB = UIStoryboard(name: "YOUR STORY BOARD", bundle: nil)
let rootVC = mainSB.instantiateViewControllerWithIdentifier("YOUR ROOT VC")
appDelegate.window!.rootViewController = rootVC
```

## Notes
- Swift 3
