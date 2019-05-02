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
        [ tree_of_depth 7

        --|> rotate (degrees -5)
        ]


main =
    graphicsApp { view = view }


tree_of_depth levels =
    tree_level levels
        |> outlined (solid 1) black


tree_level levels =
    line ( 0, -10 ) ( 0, 10 )
