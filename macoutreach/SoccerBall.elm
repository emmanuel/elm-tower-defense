soccerBall = group
              [circle 40
               |>  outlined (solid 1) black
               ,ngon 5 20 |> filled black
               ,glassPattern |> move(0,18) |> scale 1.5
               ,lines
               ,block
               ,block2 |> move(-1,0) |> rotate (degrees -72)
               ,block3
               ,block |> rotate (degrees 69)
               ,block3 |> rotate (degrees -75)
              ]
block3 = group [block  |> move(0,0.25) |> rotate (degrees -145)
               ,rect 15 2 |> filled black |> move (0,-32)

         ]
block = group [polygon [(13,38), (30,26), (24.5,22) , (12,31) ] |> filled black
           ,curve (13.5,39) [Pull (23,38) (30,28)] |> filled black |> rotate (degrees -2) |> move(0,-2)]
block2 = group [polygon [(13,39), (30,27), (24.5,22) , (12,31) ] |> filled black
           ,curve (13.5,40) [Pull (23,38) (30,29)] |> filled black |> rotate (degrees -2) |> move(0,-2)]


lines = group [rect 1 8 |> filled black |> move(12.5,34) |> rotate (degrees -10)
               ,rect 1 8 |> filled black |> move(-12.5,34) |> rotate (degrees 10)
               ,rect 1 8 |> filled black |> move(8.5,-34.5) |> rotate (degrees 15)
               ,rect 1 8 |> filled black |> move(-8.5,-34.5) |> rotate (degrees -15)
               ,rect 1 8 |> filled black |> move(27.5,23.5) |> rotate (degrees -55)
               ,rect 1 8 |> filled black |> move(-27.5,23.5) |> rotate (degrees 55)
               ,rect 1 8 |> filled black |> move(35.5,-1.25) |> rotate (degrees -80)
               ,rect 1 8 |> filled black |> move(-35.5,-1.25) |> rotate (degrees 80)
               ,rect 1 8 |> filled black |> move(31,-18) |> rotate (degrees -125)
               ,rect 1 8 |> filled black |> move(-31,-18) |> rotate (degrees 125)]
hex2 = ngon 6 5  |> filled white |> addOutline (solid 0.5) black |> scaleX 2 |> scaleY 1.5

glassPattern = group[hex2 |> rotate (degrees 36)|> move (-8.5,0)
               ,hex2 |> rotate (degrees -36) |> move (8.5,0)
               ,hex2 |> rotate (degrees 72) |> move (13.5,-16)
               ,hex2 |> rotate (degrees -72) |> move (-13.5,-16)
               ,hex2 |> move (0,-26)
              ]

myShapes model = [soccerBall]

type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }
