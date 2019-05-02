myShapes model = [ basketball |> scale 0.2 |> move (0,model.position - 30)
                 , rect 200 10 |> filled grey |> move (0, -40)
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


type Msg = Tick Float GetKeyState

update msg model =
  case msg of
    Tick t _ -> let
                  -- we need to know how much time past since the last clock tick
                  -- because velocity   = (change in position) / second
                  --   means newPostion = oldPosition + velocity * timeChange
                  -- because acceleration = (change in velocity) / second
                  --   means newVelocity  = oldVelocity + acceleration * timeChange
                  timeChange = t - model.time
                  -- new pos/vel with gravity, but no bounce
                  pWithG = model.position + model.velocity * timeChange
                  vWithG = model.velocity + gravity * timeChange
                  -- if we hit the bottom, then bounce (reverse direction)
                  (pNew,vNew) = if pWithG < 0
                                  then (-pWithG,-vWithG)
                                  else ( pWithG, vWithG)
                in
                  { time = t                -- save "now" for next time
                  , position = pNew         -- set the new position
                  , velocity = vNew         -- set the new velocity
                  }

gravity = -9.8  -- Earth gravity is -9.8 (m/s)/s
                -- meaning you fall 9.8 meters per second faster every second
                -- (until you are going fast enough for air pressure to slow you down)
                -- ((a parachute helps))

init = { time = 0            -- we set this to the current time
       , position = 60
       , velocity = 0
       }


