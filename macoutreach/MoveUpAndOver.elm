myShapes model = [
            wedge 10 0.8
            |> filled yellow
            |> move (coord model.time)
            |> rotate (degrees <| angle model.time)
           ]

coord t =
    if t < 3
       then (-80,-45)
       else
           if t < 8
               then (-80,-45 + 10 * ( t - 3))
               else
                   if t < 13
                       then (-80 + 10 * (t - 8), -45 + 10 * 5)
                       else (-80 + 10 * 5, -45 + 10 * 5)


angle t =
    if t < 8
       then 270
       else 180



type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

