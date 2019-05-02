myShapes model = [ square 100000 |> filled sky,
                  dolphin
                  |> move (-(cos(model.time*4)*40),(sin(model.time*4)*20)) ,
                  sea model.time|> move (0,-40)
                 ]
sea time= group[rect 1000 50 |> filled lightBlue 
            ,wave time]
wave time = group[oval 40 20 |> filled lightBlue |> move (0,20) |> move (0,sin(time*2)*3)
            ,oval 40 20 |> filled lightBlue |> move (-40,20) |> move (0,-(sin(time*2)*3))
            ,oval 40 20 |> filled lightBlue |> move (-80,20) |> move (0,sin(time*2)*3)
            ,oval 40 20 |> filled lightBlue |> move (0,20) |> move (0,sin(time*2)*3)
            ,oval 40 20 |> filled lightBlue |> move (40,20) |> move (0,-(sin(time*2)*3))
            ,oval 40 20 |> filled lightBlue |> move (80,20) |> move (0,sin(time*2)*3)
            
            ]
sky = rgb 200 255 255
dolphin = group[curve (-55,10) [Pull (-5,40) (60,-20),
                  Pull (80,-20) (85,-45),
                   Pull (60,-30) (65,-50),
                   Pull (45,-43) (50,-30),
                   Pull (0,0) (-50,-2),
                   Pull (-95,0) (-55,10)
                   ] |> filled darkGrey, 
                   curve (0,0) [Pull (35,55) (30,3)] |> filled darkGrey 
                   |> move (0,15) |> rotate (degrees -30),
                   curve (0,-5) [Pull (25,-55) (25,-11)] |> filled darkGrey
                   |> move (-10,0), 
                   circle 3 |> filled black |> move (-40,10),
                   circle 1 |> filled white |> move (-40,12),
                   curve (-45,-3) [Pull (5,4) (50,-31)] 
                   |> outlined (solid 2) white |> move (0,2),
                   curve (-45,0) [Pull (2,3) (50,-30)] |> outlined (solid 3) white,
                   oval  7 3.5 |> filled white |> move(-45,0) |> rotate (degrees 10)
                   ]
type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }
