myShapes model = [group [polygon ((points model.time)
                          ++
                           (List.map moveDown <| List.reverse (points model.time)))
                          |> filled red
                        , oval 20 10 |> filled red |> move (-7,3)
                        , circle 1.5 |> filled black |> move (-9,4)
                        ]
                    -- because the above shapes are grouped together, they move together
                    |> move (-5 * model.time,0)
                 ]

-- used to move the bottom of the snake below the top
moveDown : (Float,Float) -> (Float,Float)
moveDown (x,y) = (x,y+4)

-- make the pth point
mkPoint : Float -> Float -> (Float,Float)
mkPoint t p = ( 10 * p/3
              , 10 * sin t * sin (p/3)
              )

-- make a list of points for each time in the animation
points : Float -> List (Float,Float)
points t = List.map (mkPoint t)
         <| List.map toFloat
         <| List.range 0 50

type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

