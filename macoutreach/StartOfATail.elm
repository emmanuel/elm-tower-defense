myShapes model = [ openPolygon (List.map (spiral model.bend model.time) 
                                   <| List.map toFloat 
                                   <| List.range 0 100)
                    |> outlined (solid 5) (colourChange model.state)
                    |> notifyTap BillyButton
                 ]

-- spirals: https://en.wikipedia.org/wiki/Archimedean_spiral
a = 2
b = 5
spiral bend start t = ( (a + b * t) * cos (bend*t + start)
                      , (a + b * t) * sin (bend*t + start)
                      )

colourChange state = case state of 
                      Red -> red
                      Yellow -> purple
                      Green -> green
                     
type States = Red | Yellow | Green

type Msg = Tick Float GetKeyState | BillyButton
        

update msg model = case msg of
                     Tick t _ -> { model
                                 | time = t 
                                 , bend = if model.bend < 1
                                            then model.bend + 0.1*(t - model.time)
                                            else 0.01
                                 }
                     BillyButton -> {model 
                                    | state = case model.state of 
                                                Red -> Yellow
                                                Yellow -> Green
                                                Green -> Red
                                    , bend = 0.01}
                     

init = { time = 0 , state = Red, bend = 0.1}
