--module Main exposing (Msg(..), main, update, view)


module Main exposing (main, view)

import GraphicSVG exposing (..)
import GraphicSVG.App
    exposing
        ( graphicsApp
        )


view =
    collage 500
        500
        [ defender
            |> rotate (degrees -5)
        ]


main =
    graphicsApp { view = view }


defender =
    group
        [ defender_torso
        , defender_left_leg
        , defender_right_leg
        ]


defender_leg =
    group
        [ line ( 0, 0 ) ( 0, -30 )
            |> outlined (solid 2) black
        , line ( 0, -30 ) ( -5, -60 )
            |> outlined (solid 1.5) black
        ]


defender_right_leg =
    defender_leg
        |> rotate (degrees -6)
        |> move ( -22, -77 )


defender_left_leg =
    defender_leg
        |> rotate (degrees -6)
        |> move ( 22, -77 )


defender_book_curve =
    curve ( 0, 0 ) [ Pull ( 0, 6 ) ( 5, 5 ) ]
        |> outlined (solid 1) black


defender_torso =
    group
        [ curve ( -55, 70 ) [ Pull ( -55, 76 ) ( -50, 75 ) ]
            |> outlined (solid 1) black

        --defender_book_curve
        --    |> move ( -5, -5 )
        , subtract
            defender_body_rect
            (group
                [ defender_body_rect
                    |> move ( -5, -5 )
                , defender_book_curve
                    |> move ( -55, 70 )
                , defender_book_curve
                    |> move ( -55, -80 )
                , defender_book_curve
                    |> move ( 45, -80 )
                ]
            )
        , defender_body_rect
        , defender_torso_text
        , circle 30
            |> outlined (solid 1) black
            |> move ( 0, 30 )
        ]


defender_body_rect =
    rectangle 100 150
        |> outlined (solid 1) black


defender_torso_text =
    text "A Farewell To Arms"
        |> fixedwidth
        |> bold
        |> size 7
        |> filled black
        |> move ( -38, -16 )



--map fun list = case list of
--                (x :: xs) −> (fun x) :: (map fun xs)
--                [] −> []
