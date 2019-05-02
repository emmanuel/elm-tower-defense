myShapes model = [ square 10
                     |> filled (rgb 0 (150+100*sin model.time) (150-100*sin model.time))
                     |> rotate model.time
                 ]

type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

