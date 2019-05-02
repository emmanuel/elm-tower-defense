myShapes model = [ myBackground
                 , monkey  |> rotate  (degrees (sin(model.time)*100))
                 ]
monkey = group [ arms |> move(0,20)
               , feet
               , body|> move(0,20)
               , head |> move(0,20)
               ]

feet = group [ roundedRect 6 20 2 |> filled darkBrown
                 |> rotate (degrees -30)
                 |> move (-13,-13)
                 |>rotate(degrees -20)
             , roundedRect 4.5 20 2 |> filled darkBrown
                 |> rotate (degrees -30)
                 |> move (-17,-25)
                 |>rotate(degrees 50)
             , oval 8 17 |> filled skin |> move(-17,-35)
                 |>rotate (degrees -90)
             , oval 4 10 |> filled skin |> move(-13,-38)
                 |>rotate (degrees -50)
             , roundedRect 6 20 2 |> filled darkBrown
                 |> rotate (degrees 30)
                 |> move (10,-13)
                 |>rotate(degrees 30)
             , roundedRect 4.5 20 2 |> filled darkBrown
                 |> rotate (degrees -30)
                 |> move (10,-19)
                 |>rotate(degrees -50)
             , oval 8 17 |> filled skin |> move(0,-25)
                 |>rotate (degrees 30)
             , oval 4 10 |> filled skin |> move(-5,-24)
                 |>rotate (degrees 0)
             ]

arms = group [ roundedRect 4 20 2|> filled darkBrown
                 |> move(-19,-10)
                 |> rotate (degrees 55)
             , roundedRect 5 20 2|> filled darkBrown
                 |> move(-31,2)
                 |> rotate (degrees 35)
             , oval 10 15 |> filled skin
                 |> move(-36,15)
             , roundedRect 4 20 2|> filled darkBrown
                 |> move(18,-10)
                 |> rotate (degrees -55)
             , roundedRect 5 20 2|> filled darkBrown
                 |> move(28,0)
                 |> rotate (degrees -35)
             , oval 10 15 |> filled skin
                 |> move(32,10)
             ]

head = group [ oval 45 25 |> filled skin
             , circle 18|> filled darkBrown
             , circle 7 |> filled skin |> move(-7,0)
             , circle 7 |> filled skin |> move(7,0)
             , oval 30 20 |> filled skin |> move(0,-7)
             , eyes
             , oval 7 4 |> filled brown |> move(0,-5)
             , rect 1 8 |> filled brown |> move(0,-10)
             ]

eyes = group [ circle 5 |> filled white |> move (7,0)
             , circle 5 |> filled white |> move (-7,0)
             , circle 3.5 |> filled black |> move(-7,0)
             , circle 3.5 |> filled black |> move(7,0)
             , circle 1.5 |> filled white |> move(-8,2)
             , circle 1.5 |> filled white |> move(6,2)
             ]

body = group [ roundedRect 25 40 10|> filled darkBrown |> move(0,-15)
             , oval 20 30 |> filled skin |> move(0,-15)
             ]

skin = rgb 255 229 204

myBackground = square 200 |> filled lightGreen

type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

