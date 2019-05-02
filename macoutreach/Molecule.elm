-- this is a funner example of what you can learn in BlueRedPurple.elm

myShapes model = 
  let
    -- velocity depends on the state
    (vx,vy) = case model.state of
                Liquid -> (pi,2)
                Solid  -> (0.2,0.7)
                Gas    -> (57,64)
                Plasma -> (200,300)
                
  in
    [ background
    , molecule
        |> rotate ( vx * model.time)
        |> move ( 50 * sin (vx * model.time)
        , 50 * sin (vy * model.time))
        |> notifyTap ChangeState
    , text (case model.state of
                      Liquid -> "Liquid State"
                      Solid  -> "Solid State"
                      Gas    -> "Gaseous State"
                      Plasma -> "Plasma!"

           ) |> centered |> filled orange |> move (0,55)
    , text (String.fromInt model.points) |> filled black 
        |> move (84,55)
    ]

molecule = group
  [ circle 2 |> filled (rgb 0 200 0)  |> move (8,0)
  , circle 7 |> filled (rgb 0 0 250)
  , circle 2 |> filled (rgb 0 200 0)  |> move (0,8)
  ]
background = group 
  [ rect 192 128 |> filled yellow
  ]

type Msg = Tick Float GetKeyState
         | ChangeState

update msg model = 
  case msg of
    Tick t _ -> { model | time = t }
    ChangeState -> 
        { model | state = changeState model.state
                , points = model.points + 1}
        
changeState state = case state of
                      Liquid -> Gas
                      Solid  -> Liquid
                      Gas    -> Plasma
                      Plasma -> Solid

type Matter = Liquid
            | Solid
            | Gas
            | Plasma
            
init = { time = 0, state = Solid, points = 0 }
