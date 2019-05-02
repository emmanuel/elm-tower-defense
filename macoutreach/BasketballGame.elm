--This is an extension of the Basketball.elm example. If this is confusing, try looking
--at that example first. In this example, you can try to score baskets by using the arrow keys.

myShapes model = [ basketball |> scale 0.2 |> move (model.positionx,model.positiony - 20)
                 , rect 200 10 |> filled grey |> move (0, -40)
                 , hoop |> move (30,-10)
                 -- Here we display the score by converting the Integer (number) score
                 -- into a string (a series of characters which can be shown as text)
                 , text ("Score: " ++ String.fromInt model.score) |> filled black |> move(0,-45)
                 ]

basketball = group
              [ circle 40
                  |> filled orange
              , curve (-37,0) [Pull (10,10) (31,-10)]
                  |> outlined (solid 1) black
                  |> move (0,-15)
              , curve (37,0) [Pull (-10,-10) (-31,10)]
                  |> outlined (solid 1) black
                  |> move (0,15)
              , curve (-40,0) [Pull (5,0) (40,-10)]
                  |> outlined (solid 1) black
                  |> move (0,4)
              , curve (-40,0) [Pull (5,0) (40,-10)]
                  |> outlined (solid 1) black
                  |> rotate 190
                  |> move (-5,0)
              ]
              
hoop = group [
               roundedRect 8 50 5
                  |> filled black 
             , curve (0,0) [Pull  (10,0) (25,-10)]
                  |> filled red 
                  |> rotate (degrees -150) 
                  |> move (0,25)
             ,  rectangle 6 25 
                  |> filled darkGrey 
                  |> move (0,35)
             ,  curve (0,0) [Pull (10,0) (25,10)]
                  |>filled grey
                  |> move (-23,6) 
                  |> rotate (degrees 20)
             ,  curve (0,0) [Pull (10,0) (25,10)]
                  |>filled grey
                  |> move (-25,21)
                  |> rotate (degrees -50)
             ]
 

type Msg = Tick Float GetKeyState

update msg model =
  case msg of
    Tick t (_,(x,y),_) -> 
                 let
                  -- we need to know how much time past since the last clock tick
                  -- because velocity   = (change in position) / second
                  --   means newPostion = oldPosition + velocity * timeChange
                  -- because acceleration = (change in velocity) / second
                  --   means newVelocity  = oldVelocity + acceleration * timeChange
                  timeChange = t - model.time
                  -- new pos/vel with gravity, but no bounce
                  pWithG = model.positiony + model.velocityy * timeChange
                  vWithG = model.velocityy + gravity * timeChange
                  -- if we hit the bottom, then bounce (reverse direction)
                  (pNew,vNew) = if pWithG < 0
                                  then (-pWithG,-vWithG)
                                  else ( pWithG, vWithG)
                in
                  { time = t                -- save "now" for next time
                  , positiony = pNew         -- set the new position
                  , positionx = model.positionx + model.velocityx * 0.1
                  , velocityy = vNew         -- set the new velocity
                    -- This detects whether the ball bounces off the backboard
                  , velocityx = if model.positionx >= 15 
                                && model.velocityx > 0 then 
                                  -(model.velocityx + x) --Here, we reverse the x-velocity if we detect a backboard bounce
                                else model.velocityx + x
                    -- Increase the score if the ball satisfies some constraints
                    -- The first four constraints have to do with the ball's position
                  , score = if model.positionx >= 5  
                            && model.positionx <= 15 
                            && model.positiony >= 25 
                            && model.positiony <= 35 
                            && model.velocityy < 0 -- The ball's y velocity must be negative (the ball is falling)
                            && t - model.lastScoreTime > timeBetweenGoals -- This is so we only give 2 points per basket
                            then                                          -- Try setting timeBetweenGoals = 0 to see why this is needed
                               model.score + 2 
                            else model.score
                    -- If we score a point (see explanation of the constraints above)
                    -- then we need to store the time that the basket was scored so we can
                    -- avoid giving out many points for one basket
                  , lastScoreTime = if model.positionx >= 5 
                                 && model.positionx <= 15 
                                 && model.positiony >= 25 
                                 && model.positiony <= 35 
                                 && model.velocityy < 0 
                                 && t - model.lastScoreTime > timeBetweenGoals 
                                    then t --if we scored a basket, store the current time
                                 else model.lastScoreTime --otherwise keep it the same
                  }
                  
--Set the minimum time (in seconds) between baskets
timeBetweenGoals = 5

gravity = -9.8  -- Earth gravity is -9.8 (m/s)/s
                -- meaning you fall 9.8 meters per second faster every second
                -- (until you are going fast enough for air pressure to slow you down)
                -- ((a parachute helps))

init = { time = 0            -- we set this to the current time
       , lastScoreTime = -timeBetweenGoals -- start the last score time as the negative
                                           -- of the time between goals, so that the 
                                           -- first goal can be scored anytime and not just
                                           -- after timeBetweenGoals seconds
       -- Initial x- and y-velocities and positions of the ball
       , positiony = 60
       , positionx = 0
       , velocityy = 0
       , velocityx = 0
       , score = 0 -- Initially, they have no score
       }