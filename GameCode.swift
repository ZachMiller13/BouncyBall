import Foundation
// initializes the circle
let circle = OvalShape(width: 150, height: 150)
// initializes the barriers
let barrierWidth = 300.0
let barrierHeight = 25.0
// assigns locations to barriers
let barrierPoints = [
Point(x: 0, y: 0),
Point(x: 0, y: barrierHeight),
Point(x: barrierWidth, y: barrierHeight),
Point(x: barrierWidth, y: 0)
]

let barrier = PolygonShape(points: barrierPoints)

// initialize the funnel
let funnelPoints = [
    Point(x: 0, y: 50),
    Point(x: 80, y: 50),
    Point(x: 60, y: 0),
    Point(x: 20, y: 0)
]

let funnel = PolygonShape(points: funnelPoints)
/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

func setup() {
// Adds circle to the Window
    circle.position = Point(x: 250, y: 400)
    scene.add(circle)
    //Adds acceleration downwards, caused by gravity
    circle.hasPhysics = true
    
    
    //Add a barrier to the scene
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    scene.add(barrier)
    
    barrier.isImmobile = true
    
    //Add funnel to the scene
    funnel.position = Point(x: 200, y: scene.height - 25)
    scene.add(funnel)
    
    //Callback to drop ball when funnel is tapped
    funnel.onTapped = dropBall
}

//Drops the ball by moving it to the funnels position
func dropBall() {
    circle.position = funnel.position
}

