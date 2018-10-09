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

        --|> rotate (degrees -5)
        ]


main =
    graphicsApp { view = view }


defender =
    group
        [ defender_torso
        , defender_right_arm
        , defender_left_arm
        , defender_left_leg
        , defender_right_leg
        ]


defender_upper_leg_end =
    ( 0, -30 )


defender_leg =
    group
        [ defender_upper_leg
        , defender_lower_leg
            |> move defender_upper_leg_end
        ]


defender_upper_leg =
    line ( 0, 0 ) defender_upper_leg_end
        |> outlined (solid 2) black


defender_lower_leg =
    line ( 0, 0 ) ( -5, -30 )
        |> outlined (solid 1.5) black


defender_arm =
    group
        [ defender_upper_arm
        , defender_lower_arm
            |> move defender_upper_arm_end
        ]


defender_upper_arm_end =
    ( -20, -15 )


defender_upper_arm =
    line ( 0, 0 ) defender_upper_arm_end
        |> outlined (solid 1.5) black


defender_lower_arm =
    line ( 0, 0 ) ( -10, -15 )
        |> outlined (solid 1.5) black


defender_right_arm =
    defender_arm
        |> rotate (degrees -6)
        |> move ( -52, 0 )


defender_left_arm =
    defender_arm
        |> rotate (degrees 106)
        |> move ( 50, 0 )


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
        , ngon 8 29
            |> outlined (solid 1) black
            |> move ( 0, 30 )

        --, ngon 6 27
        --    |> outlined (solid 1) black
        --    --|> rotate (degrees 18)
        --    |> move ( 0, 30 )
        --, ngon 5 23
        --    |> outlined (solid 1) black
        --    |> rotate (degrees 18)
        --    |> move ( 0, 30 )
        --, ngon 3 22
        --    |> outlined (solid 1) black
        --    |> rotate (degrees 6)
        --    |> move ( 0, 30 )
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
