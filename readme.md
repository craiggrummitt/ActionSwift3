![ActionSwift.png](ActionSwift.png)

**ActionSwift 3.0**

*ActionScript 3 SDK in Swift*

Swift is awesome - but do you ever reminisce about the old days of ActionScript 3.0? The old days of DisplayObjects, Sprites, MovieClips, EventDispatchers - oh and who can forget gotoAndPlay? Well, now you can enjoy iOS native development using the power of Swift syntax but with the AS3 SDK! Whaa? How is this possible? Is this heresy?

**ActionSwift3**

Underneath the hood ActionSwift3 is based on the SpriteKit SDK but the ActionSwift 3 SDK is based on familiar AS3 SDK classes:

*   DisplayObject
*   InteractiveObject
*   DisplayObjectContainer
*   Sprite
*   Graphics
*   Stage
*   MovieClip
*   EventDispatcher
*   Event
*   EventHandler
*   Touch
*   TouchEvent (in a touch environment TouchEvent makes more sense to use than MouseEvent)

Easing classes are also included for convenience from [here](https://github.com/craiggrummitt/SpriteKitEasingSwift).

**ActionSwiftSK**

ActionSwiftSK is a sample project that you can play with ActionSwift3. Start with taking a look at GameViewController.swift. GameViewController does the following:

1. Sets up the stage.
2. Creates a sprite that draws a circle and a rectangle. 
3. Creates a movieclip that displays textures defined by an array of strings referring to the images in the folder 'images.atlas'. 
4. Shows how to create an event listener by setting up a drag-drop operation.

![screenshot.png](screenshot.png)

**How to use ActionSwift3**

Here is some sample code to get your head around how to use ActionSwift3.

***Stage***

To begin with, you need to set up the Stage in a ViewController that contains a SKView(this is done for you automatically if you set up a Game-SpriteKit project)

```Swift
let stage = Stage(self.view as! SKView)
```

***Sprite***

You can now call familiar methods on the stage. For example, you could instantiate a sprite, and draw a rectangle on its graphics property, and then add this sprite to the stage:

```Swift
let sprite = Sprite()
sprite.graphics.beginFill(UIColor.redColor())
sprite.graphics.drawRect(10,10,100,44)
sprite.name = "shapes"
stage.addChild(sprite)
```

***MovieClip***

To create a movieclip, you will need images within a folder with the extension 'atlas' in your project (eg.'images.atlas'). This will automatically generate a Texture Atlas. Set up an array of these image file names, and pass them in when you instantiate a MovieClip. These will now be the 'frames' of your movieclip, which you will be able to call familiar methods - gotoAndPlay(), gotoAndStop(), stop() and play(). Use Stage.size to get the dimensions of the device.

```Swift
let walkingTextures = ["walking1","walking2","walking3"]
let movieClip = MovieClip(textureNames: walkingTextures)
movieClip.x = 0
movieClip.y = Stage.size.height - movieClip.height
stage.addChild(movieClip)
```

***EventDispatcher***

Just as you would expect, Sprites and MovieClips will dispatch events. As Swift is not able to check equality between two functions, an additional class called 'EventHandler' stores the EventHandler, along with a string representing the EventHandler, that can be checked for equality. For example, here's how to set up an enterFrame event handler:

```Swift
movieClip.addEventListener(EventType.EnterFrame.rawValue, EventHandler(enterFrame, "enterFrame"))
func eventHandler(event:Event) -> Void {
    trace("This is called every frame")
}
```

***trace***

Oh yeah - and trace is back!

```Swift
trace("This is the most amazing thing I've ever seen, trace is back! How did they do this?")
```

**Enhancements**

ActionSwift3 is a work in progress, feel free to contribute! 

Ideas for enhancements:

*   TextField
*   SimpleButton
*   Date
*   XML
*   Sound
*   Add more complex shapes on Graphics

***Credits***

"Walking animation" by [Kyoux](http://kyoux.deviantart.com/)
"ActionScript" by Adobe Systems Inc.
"Swift" by Apple Inc.
"Swift logo" by Apple Inc.