bodyColour = rgb 1 123 224
beakColour = rgb 208 31 81

hummingbird model =
  let
    beat1 a b = a + (b-a) * 0.5 * (cos (20*model.time) + 1)
    beat2 a b = a + (b-a) * 0.5 * (cos (20*model.time + 1) + 1)

  in
    group [ curve (0,2) [Pull (0,5.5) (3,4)
                         ,Pull (1,-4) (-1,-5)
                         ,Pull (-3,-6) (-5,-7)
                         ,Pull (-4,-3) (0,2)
                         ]
               |> filled bodyColour
           , curve (3,4) [Pull (4,4.3) (9,4.3)
                         ,Pull (4,3.8) (2.9,3.5)
                         ]
               |> filled beakColour
           , oval 0.75 0.6 |> filled black |> move (1.9,3.7)
           , oval 0.75 0.6 |> filled grey |> move (1.95,3.75) |> scale 0.3
           , curve (beat1 0 2,0) [Pull (beat1 5 -5,-5) (beat1 15 -12,beat1 0 2)
                                 ,Pull (beat1 2 -2,beat1 1 3) (beat1 0 2,0)]
               |> filled bodyColour
               |> makeTransparent 0.5
           , curve (beat2 0 2,0) [Pull (beat2 5 -5,-5) (beat2 15 -12,beat2 0 2)
                                 ,Pull (beat2 2 -2,beat2 1 3) (beat2 0 2,0)]
               |> filled bodyColour
               |> makeTransparent 0.5

           ] |> scale 5

petalColour = rgb 224 0 224
nectarColour = rgb 224 100 224

myShapes model = [ group [ oval 30 15 |> filled petalColour
                         , oval 15 30 |> filled petalColour
                         , circle 5  |> filled nectarColour
                         ]
                      |> move (50,20)
                 , group [ oval 30 15 |> filled petalColour
                         , oval 15 30 |> filled petalColour
                         , circle 5  |> filled nectarColour
                         ]
                      |> move (60,45)
                 , group [ oval 30 15 |> filled petalColour
                         , oval 15 30 |> filled petalColour
                         , circle 5  |> filled nectarColour
                         ]
                      |> move (70,12)
                 , hummingbird model |> move (20 * sin model.time, 10 * sin model.time + 5 * sin (4*model.time))
                                     |> move (-20,20)
                 , hummingbird model |> move (20 * sin (3+model.time), 10 * sin (2+model.time) + 5 * sin (4*model.time))
                                     |> move (-30,20)
                 , hummingbird model |> move (20 * sin (5+model.time), 10 * sin (10+model.time) + 5 * sin (4*model.time))
                                     |> move (-25,20)
                 ]

type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }


