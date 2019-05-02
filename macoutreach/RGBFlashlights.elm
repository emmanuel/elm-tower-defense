myShapes model =
  let
    frac = 0.5 + 0.5 * sin model.time
  in
    ( text ("rgb colour"
           ) |> centered
             |> size 6
             |> underline
             |> filled (rgb 0 0 255)
             |> addHyperlink "https://en.wikipedia.org/wiki/RGB_color_model"
             |> move (0,55)
    ) ::
    ( text ("rgb " ++ (String.fromInt <| 50 * model.red) ++
               " " ++ (String.fromInt <| 50 * model.green) ++
               " " ++ (String.fromInt <| 50 * model.blue)
           ) |> centered
             |> selectable
             |> fixedwidth
             |> size 6
             |> filled black
             |> move (0,-55)
    ) ::
    ( circle 28
      |> filled (rgb (50 * toFloat model.red) (50 * toFloat model.green) (50 * toFloat model.blue))
    ) ::
    ( (List.map3 rotFlashlight (List.range 1 5)
                               ((List.repeat model.red (rgb 255 0 0)) ++ (List.repeat (5-model.red) (rgb 40 20 20)))
                               ((List.repeat model.red LessRed) ++ (List.repeat (5-model.red) MoreRed))
      ) ++
      (List.map3 rotFlashlight (List.range 7 11)
                               ((List.repeat model.green (rgb 0 255 0)) ++ (List.repeat (5-model.green) (rgb 40 20 20)))
                               ((List.repeat model.green LessGreen) ++ (List.repeat (5-model.green) MoreGreen))
      ) ++
      (List.map3 rotFlashlight (List.range 13 17)
                               ((List.repeat model.blue (rgb 0 0 255)) ++ (List.repeat (5-model.blue) (rgb 40 20 20)))
                               ((List.repeat model.blue LessBlue) ++ (List.repeat (5-model.blue) MoreBlue))
      )
    )

rotFlashlight idx clr msg = flashlight clr |> rotate (2*pi*(toFloat idx)/18) |> notifyTap msg

flashlight clr =
  group
    [ oval 8 1 |> filled clr
        |> move (0,-39.8)
    , polygon [ (4,0), (2,-3), (2,-10), (-2,-10), (-2,-3), (-4,0), (4,0) ]
        |> outlined (solid 0.5) black
        |> move (0,-40)
    , circle 1 |> filled clr
        |> move (0,-45)
    , rect 4 0.2 |> filled black |> move (0,-43.5)
    , rect 4 0.2 |> filled black |> move (0,-46.5)
    , rect 4 0.2 |> filled black |> move (0,-47.5)
    , rect 4 0.2 |> filled black |> move (0,-48.5)
    , rect 0.2 3 |> filled black |> move (1.35,-45)
    , rect 0.2 3 |> filled black |> move (-1.35,-45)
    ]

type Msg = Tick Float GetKeyState
         | MoreRed
         | LessRed
         | MoreBlue
         | LessBlue
         | MoreGreen
         | LessGreen

update msg model = case msg of
                     Tick t _ -> { model | time = t }
                     MoreRed -> { model | red = inc model.red }
                     LessRed -> { model | red = sub model.red }
                     MoreBlue -> { model | blue = inc model.blue }
                     LessBlue -> { model | blue = sub model.blue }
                     MoreGreen -> { model | green = inc model.green }
                     LessGreen -> { model | green = sub model.green }

inc x = if x < 5 then x + 1 else 5
sub x = if x > 0 then x - 1 else 0

init = { time = 0, red = 3, blue = 3, green = 3 }
