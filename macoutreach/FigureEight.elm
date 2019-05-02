myShapes model = [ circle 10
                     |> filled (rgb 0 (150+100*sin model.time) (150-100*sin model.time))
                     |> move ( 50 * sin (2*model.time)
                             , 50 * sin (1*model.time)
                             )
                 ]

type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

