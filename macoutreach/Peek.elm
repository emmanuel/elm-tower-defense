myShapes model = [
                   pikachu model.time 1.2 model.face|> move (10,15)
                    |> notifyTap ButtonFace
                   ,text "click pikachu" |> filled black
                    |> move (30,-30)


                 ]


light = group [rect 1 12 |> filled black |> rotate (degrees -35)
                ,rect 1 7 |> filled black |> rotate (degrees -10) |> move(2.5,1)
                ,rect 8 1 |> filled black |> move(0,-5)
                ,rect 8 1 |> filled black |> move(6,-2)
                ,rect 1 12 |> filled black |> rotate (degrees -35) |> move (7,-7)
                ,rect 1 7 |> filled black |> rotate (degrees -10) |> move(4,-8)

          ]

pikachu t size f= group [tail |> move(sin(t),cos(t))
                        |> rotate (degrees (sin(t*3)*4))
                 ,body
                 ,hand |> rotate (degrees 130)
                  |> move (-25,-24)
                 ,head f |> rotate (degrees -15)
                   |> rotate (degrees (sin(t)*5))
                 ,hand
                 ,circle 5 |> filled yellow
                  |> move (-17,-25)
                 ,circle 5 |> filled yellow
                  |> move (0,-25)
                 ,foot |> rotate (degrees (sin(t)))
                 , foot |> move (48,-16)
                 |> rotate (degrees (sin(t)*(-0.5)))
                    |> rotate (degrees -30)
                 ,circle 3 |> filled yellow
                   |> move (5,-50)

              ] |> scale size



tail = group [rect 16 8 |> filled yellow
                |> move (-31,-25)
                |> rotate (degrees -30)
              ,rect 10 20 |> filled yellow
                |> move (-35,-15.5)
                |> rotate (degrees -30)
              ,rect 30 20 |> filled yellow
                |> move (-40,-5)
                |> rotate (degrees -30)
              ,rect 10 5  |> filled darkBrown
                |> move (-27,-38)
                |> rotate (degrees -30)
              ,rect 5.5 10 |> filled darkBrown
                |> move (-30, -33.3)
                |> rotate (degrees -30)

            ]

foot = group [ oval 5 17 |> filled yellow
                |> addOutline (solid 0.2) black
                |> move (-18,-47)
                |> rotate (degrees 10)
              ,rect 0.2 4 |> filled black
                |> move(-19.5,-41)
                |>rotate (degrees 10)
              ,rect 0.2 4 |> filled black
                |> move(-18.5,-41)
                |>rotate (degrees 10)

            ]

body = group [
              roundedRect 25.3 40.3 10 |> filled black
                 |> move (-13,-34)
                 |> rotate (degrees -15)
              ,roundedRect 25 40 10 |> filled yellow
                 |> move (-7,-35)
              ,roundedRect 25 40 10 |> filled yellow
                 |> move (-13,-34)
                 |> rotate (degrees -15)
              , curve (-23,-41)  [Pull (-17,-35) (-12,-43)]
                  |> outlined (solid 0.3) black
              , oval 15 5 |> filled white
                  |> move (-7.5,-55)
                  |> rotate ( degrees -8)
              ,curve (5,-38) [Pull (10,-36) (10,-45)]
                  |> filled yellow
                  |> addOutline (solid 0.2) black
                  |>move (-1,-0.5)
              ,circle 8 |> filled yellow
                  |> move (3,-47)
              ]

hand = group [ oval 30 11 |> outlined (solid 0.3) black
                |> move(-25,-15)
                |> rotate (degrees -60)
               ,triangle 1.5 |> filled yellow
                |> addOutline (solid 0.1) black
                |> move (-34,-5)
                |>rotate (degrees 30)
               ,triangle 1.5 |> filled yellow
                |> addOutline (solid 0.1) black
                |> move (-33.5,-3)
                |>rotate (degrees 23)
               ,triangle 1.5 |> filled yellow
                |> addOutline (solid 0.1) black
                |> move (-32,-2)
                |>rotate (degrees 7)
               ,triangle 1.5 |> filled yellow
                |> addOutline (solid 0.1) black
                |> move (-30.5,-2)
                |>rotate (degrees -10)
               ,triangle 1.5 |> filled yellow
                |> addOutline (solid 0.1) black
                |> move (-29,-2)
                |>rotate (degrees -45)

               ,oval 30 11 |> filled yellow
                |> move(-25,-15)
                |> rotate (degrees -60)


              ]

head f= group [oval 35.3 10.3 |> filled black
                |> move(-23,15)
              |> rotate (degrees -45)
             ,oval 35.3 10.3 |> filled black
                |> move(23,15)
              |> rotate (degrees 45)
             ,oval 38.3 23.3 |> filled black
             ,oval 40.3 26.3 |> filled black
                |> move (0,-11)
             ,oval 38 23 |> filled yellow
             ,oval 40 26 |> filled yellow
              |> move (0,-11)
             ,rect 37 10 |> filled yellow
              |> move (0,-7)
             ,oval 35 10 |> filled yellow
              |> move(-23,15)
              |> rotate (degrees -45)
             ,curve (-30,15)[Pull (-42,34) (-28,25)] |> filled black

             ,oval 35 10 |> filled yellow
              |> move(23,15)
              |> rotate (degrees 45)
             ,curve (30,15)[Pull (42,34) (28,25)] |> filled black

             ,roundedRect 3 1 5 |> filled black
              |> move (0,-6)
             ,circle 4 |> filled lightRed
              |> addOutline (solid 0.3) black
              |> move (-16,-12)
             ,circle 4 |> filled lightRed
              |> addOutline (solid 0.3) black
              |> move (16,-12)
             ,(faceChange f)
             ]

faceChange face = case face of
                      Face1 -> face1
                      Face2 -> face2
                      Face3 -> face3
                      Face4 -> face4

type Face = Face1 | Face2 | Face3 | Face4

type Msg = Tick Float GetKeyState
              | ButtonFace


update msg model = case msg of
                     Tick t _ -> { model | time = t }
                     ButtonFace -> { model | face = case model.face of
                                                     Face1 -> Face2
                                                     Face2 -> Face3
                                                     Face3 -> Face4
                                                     Face4 -> Face1
                                    }

init = { time = 0, face = Face1 }

face1 = group[circle 4 |> filled black
              |> move (-10,-2)
             ,circle 4 |> filled black
              |> move (10,-2)
             ,circle 2 |> filled white
              |> move (9,-0.5)
             ,circle 2 |> filled white
              |> move (-9,-0.5)
             ,curve (-4.5,-10) [Pull (0,-28) (4.5,-10)] |> filled darkRed |>addOutline (solid 0.5) black
             ,curve (-6,-10) [Pull (-3,-12) (0,-10)] |> filled yellow |> addOutline (solid 0.5) black
             ,curve (6,-10) [Pull (3,-12) (0,-10)] |> filled yellow |> addOutline (solid 0.5) black
             ,curve (-3.5,-14) [Pull (0,-11) (3.5,-14)] |> filled (rgb 250 128 114) |> addOutline (solid 0.5) black
             ,curve (-3.4,-14) [Pull (0,-27.5) (3.4,-14)] |> filled (rgb 250 128 114) |> addOutline (solid 0.5) black

         ]

face2 = group [
            circle 4 |> filled black
              |> move (-10,-2)
             ,circle 4 |> filled black
              |> move (10,-2)
             ,circle 2 |> filled white
              |> move (9,-0.5)
             ,circle 2 |> filled white
              |> move (-9,-0.5)
             ,curve (-4.5,-10) [Pull (0,-15) (4.5,-10)] |> filled darkRed |>addOutline (solid 0.5) black
             ,curve (-6,-10) [Pull (-3,-12) (0,-10)] |> filled yellow |> addOutline (solid 0.5) black
             ,curve (6,-10) [Pull (3,-12) (0,-10)] |> filled yellow |> addOutline (solid 0.5) black
             ,rect 8 15 |> filled yellow
               |>move (-5,4)
               |>rotate (degrees 80)
             ,rect 8 15 |> filled yellow
               |>move (5,4)
               |>rotate (degrees -80)

            ]

face3 = group [
              circle 4 |> filled black
              |> move (-10,-2)
             ,circle 4 |> filled black
              |> move (10,-2)
             ,circle 2 |> filled white
              |> move (9,-0.5)
             ,circle 2 |> filled white
              |> move (-9,-0.5)
             ,curve (-6,-10) [Pull (-3,-12) (0,-10)] |> filled yellow |> addOutline (solid 0.5) black
             ,curve (6,-10) [Pull (3,-12) (0,-10)] |> filled yellow |> addOutline (solid 0.5) black
             ,rect 8 15 |> filled yellow
               |>move (-5,3)
               |>rotate (degrees 80)
             ,rect 8 15 |> filled yellow
               |>move (5,3)
               |>rotate (degrees -80)
          ]

face4 = group [
              roundedRect 10 3.5 2 |> filled white
                |> addOutline (solid 0.3) black
                |> move (0,-12)
             ,rect 6 0.3 |> filled black
                 |> move (0,-12)
             ,curve (-6,-10) [Pull (-3,-12) (0,-10)] |> filled yellow |> addOutline (solid 0.5) black
             ,curve (6,-10) [Pull (3,-12) (0,-10)] |> filled yellow |> addOutline (solid 0.5) black
             ,rect 8 15 |> filled yellow
               |>move (-5,3)
               |>rotate (degrees 80)
             ,rect 8 15 |> filled yellow
               |>move (5,3)
               |>rotate (degrees -80)
             ,rect 1 8 |> filled black
                |> move (-10,0)
                |> rotate (degrees 60)
             ,rect 1 8 |> filled black
                |> move (-10,-4)
                |> rotate (degrees -60)
              ,rect 1 8 |> filled black
                |> move (10,0)
                |> rotate (degrees -60)
             ,rect 1 8 |> filled black
                |> move (10,-4)
                |> rotate (degrees 60)
             ,light |> rotate (degrees 50) |> move (-40, 10) |> scale 1.5
             ,light |> rotate (degrees -70) |> move (40, 10) |> scale 1.5
          ]

