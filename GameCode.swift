import Foundation
// initializes the ball
let ball = OvalShape(width: 40, height: 40)
// initializes the barriers
var barriers: [Shape] = []
// initializes the targets
var targets: [Shape] = []

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

fileprivate func setupBall() {
    // Adds ball to the Window
    ball.position = Point(x: 250, y: 400)
    scene.add(ball)
    //Adds acceleration downwards, caused by gravity
    ball.hasPhysics = true
    ball.fillColor = .blue
    ball.onCollision = ballCollided(with:)
    ball.isDraggable = false
    scene.trackShape(ball)
    ball.onExitedScene = ballExitedScene
    ball.onTapped = resetGame
    ball.bounciness = 0.6
}

fileprivate func addBarrier(at position: Point, width: Double, height: Double, angle: Double) {
    //Adds additional barrier and appends to array
    let barrierPoints = [
        Point(x: 0, y: 0),
        Point(x: 0, y: height),
        Point(x: width, y: height),
        Point(x: width, y: 0)
    ]
    let barrier = PolygonShape(points: barrierPoints)
    barriers.append(barrier)
    
    //Add a barrier to the scene
    barrier.position = position
    barrier.hasPhysics = true
    scene.add(barrier)
    barrier.isImmobile = true
    barrier.fillColor = .green
    barrier.angle = angle
}

fileprivate func setupFunnel() {
    //Add funnel to the scene
    funnel.position = Point(x: 200, y: scene.height - 25)
    scene.add(funnel)
    //Callback to drop ball when funnel is tapped
    funnel.onTapped = dropBall
    funnel.fillColor = .darkGray
    funnel.isDraggable = false
}

func setup() {
    setupBall()
    addBarrier(at: Point(x: 300, y: 250), width: 80, height: 25, angle: 0.1)
    addBarrier(at: Point(x: 90, y: 300), width: 80, height: 25, angle: -0.1)
    addBarrier(at: Point(x: 320, y: 600), width: 100, height: 5, angle: 0)
    setupFunnel()
    addTarget(at: Point(x: 345, y:652))
    addTarget(at: Point(x: 71, y:439))
    addTarget(at: Point(x: 317, y: 325))
    resetGame()
    scene.onShapeMoved = printPosition(of:)
}

//Drops the ball by moving it to the funnels position
func dropBall() {
    ball.position = funnel.position
    ball.stopAllMotion()
    for barrier in barriers {
        barrier.isDraggable = false
    }
}

//Setup a target function to add to scene
func addTarget(at position: Point) {
    let targetPoints = [
    Point(x: 10, y: 0),
    Point(x: 0, y: 10),
    Point(x: 10, y: 20),
    Point(x: 20, y: 10)
    ]
    let target = PolygonShape(points: targetPoints)
    targets.append(target)
    target.position = position
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = true
    target.fillColor = .yellow
    scene.add(target)
    target.name = "target"
    target.isDraggable = false
    
}

//Handles collisions between the ball and targets
func ballCollided(with otherShape: Shape) {
    if otherShape.name != "target" {return}
    otherShape.fillColor = .orange
}

//prevents the ball from falling forever
func ballExitedScene() {
    for barrier in barriers {
        barrier.isDraggable = true
    }
}

//resets the game by moving the ball below the scene, which will unlock the barriers.
func resetGame() {
    ball.position = Point(x: 0, y: -80)
}

func printPosition(of shape: Shape) {
    print(shape.position)
}
