crustColour = rgb 172 105 30
crumbColour = rgb 192 125 50

outside = group [ square 35
                     |> filled crustColour
                 , oval 45 20
                     |> filled crustColour
                     |> move (0,20)
                ]

knife = group [ curve (0,0) [Pull (0,0) (80,0), Pull (80,0) (80,17), Pull (31,18) (0,0), Pull (0,0) (0,0), Pull (0,0) (0,0), Pull (0,0) (0,0), Pull (0,0) (0,0) ]
                  |> filled (rgb 225 225 225)
                  |> move (-40,0)
              , curve (0,0) [Pull (0,0) (31,0), Pull (39,10) (21,20), Pull (17,20) (0,20) ]
                  |> filled black
                  |> move (20,0)
              ]
              
myShapes model = [group [ outside
                     |> move (-20,0)
                 , square 30
                     |> filled crumbColour
                     |> move (-20,0)
                 , oval 40 15
                     |> filled crumbColour
                     |> move (-20,20)
                 , knife  |> move (-5, 12 + 30 * (sin model.time))
                 , outside |> move (-20,if cos model.time <= 0 then 0 else 200)
                 ] |> move (0,-20) ]

myBackground = square 200 |> filled white


type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

