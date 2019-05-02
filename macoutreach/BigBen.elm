myShapes model = [ bigBen model.time  |> scale 0.7
                 ]

bigBen time= group[head |> move (0,-30)
                  ,rec |> move(0,-55)
                  ,poly |> move(0,-55)
                  ,clock time |> move(0,-55)
             ]
head = group[ polygon [(25,15),(20,-10),(-20,-10),(-25,15)] |> filled darkBrown
              ,rect 48 1 |> filled yellow |> move (0,10)
              ,rect 51 7 |> filled yellow |> move (0,18)
              ,polygon [(15,10),(27,-10),(-27,-10),(-15,10)] |> filled darkGray |> move(0,30)
              ,rect 30 17 |> filled yellow |> move(0,48)
              ,rect 3 12 |> filled black |> move (5,48)
              ,rect 3 12 |> filled black |> move (-5,48)
              ,rect 3 12 |> filled black |> move (10,48)
              ,rect 3 12 |> filled black |> move (-10,48)
              ,rect 3 12 |> filled black |> move (0,48)
              ,polygon [(0,90),(18,50),(-18,50)] |> filled darkGrey
              ,rect 2 10 |> filled darkGrey |> move (0,90)
              , circle 3 |> filled yellow |> move (0,92)
              ]
rec = group [ rect 75 50 |> filled brown
              , rect 3 50 |> filled darkBrown |> move (-35,0)
              , rect 3 50 |> filled darkBrown |> move (-30,0)
              , rect 3 50 |> filled darkBrown |> move (30,0)
              , rect 3 50 |> filled darkBrown |> move (35,0)
              ]
poly = group [ polygon [(28,30),(25,-25),(-25,-25),(-28,30)] |> filled brown
              , roundedRect 5 54 6|> filled darkBrown |> move (0,3)
              , roundedRect 5 54 6|> filled darkBrown |> rotate (degrees 10) |> move (-8,3)
              , roundedRect 5 54 6|> filled darkBrown |> rotate (degrees -10) |> move (8,3)
              , roundedRect 5 54 6|> filled darkBrown |> rotate (degrees 5) |> move (-20,3)
              , roundedRect 5 54 6|> filled darkBrown |> rotate (degrees -5) |> move (20,3)
               ]
hourHand = group[roundedRect 2 20 2|> filled grey
                ,roundedRect 3 10 2|> filled brown |> move (0,-5)

                ]
clock time= group [square 42 |> filled brown |> addOutline (solid 1) blue
                  ,hourHand  |> rotate (degrees (time*50))
                  ,handMin |> rotate (degrees (time*50))
                   ,circle 20 |> outlined (solid 2) blue
                   ,square 45 |> outlined (solid 2) yellow
                   ]

handMin = group[rect 30 1 |> filled darkGrey
                   ,rect 15 2 |> filled brown |> move (10,0)
                   ]

type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

