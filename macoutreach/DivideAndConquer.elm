myShapes model = [ square 1000 |> filled black
                 , recurse model.depth model.time
                 ]


recurse n t = if n > 0 
              then group [ square 20 |> filled (hsl (1-1/n) 1 0.5)
                         , recurse (n-1) t
                            |> scale 0.5
                            |> move (30,0)
                         , recurse (n-1) t
                            |> scale 0.5
                            |> move (-30,0)
                         , recurse (n-1) t
                            |> scale 0.5
                            |> move (0,30)
                         , recurse (n-1) t
                            |> scale 0.5
                            |> move (0,-30)
                          ] |> rotate (-t/n)
                            |> notifyTap Click
               else square 10 |> filled (hsl 0 1 0.5)
               
update msg model =
  case msg of
    Tick t _ -> { model | time = t }
    Click    -> { model | depth = model.depth + 1 }
    
type Msg = Tick Float GetKeyState
         | Click

init = { time = 0, depth = 4 }
