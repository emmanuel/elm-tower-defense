module Main exposing (main, view)

import GraphicSVG exposing (..)
import GraphicSVG.App


main =
    GraphicSVG.App.gameApp Tick
        { model = init
        , update = update
        , view = view
        }


type Msg
    = Tick Float GraphicSVG.App.GetKeyState
    | AnimateAngle Int


update msg model =
    case msg of
        Tick t _ ->
            { model | savedTime = t, time = t - model.startTime }

        AnimateAngle parts ->
            { model | numParts = parts, startTime = model.savedTime, time = 0 }


init =
    { startTime = 0, savedTime = 0, time = 0, numParts = 8 }


view model =
    let
        numParts =
            toFloat model.numParts
    in
    collage 500
        500
        [ blossomRow (redBlossom numParts) (greenBlossom numParts) (blueBlossom numParts)
            |> move ( 0, 160 )
        , hueBlossom numParts
            |> move ( -200, 60 )
        , saturationBlossom numParts
            |> move ( -100, 60 )
        , luminanceBlossom numParts
            |> move ( 0, 60 )
        ]


blossomRow blossom1 blossom2 blossom3 =
    group
        [ blossom1 |> move ( -200, 0 )
        , blossom2 |> move ( -100, 0 )
        , blossom3 |> move ( 0, 0 )
        ]


redBlossom numParts =
    group
        [ redPetal numParts 0
        , redPetal numParts 1
        , redPetal numParts 2
        , redPetal numParts 3
        , redPetal numParts 4
        , redPetal numParts 5
        , redPetal numParts 6
        , redPetal numParts 7
        ]


greenBlossom numParts =
    group
        [ greenPetal numParts 0
        , greenPetal numParts 1
        , greenPetal numParts 2
        , greenPetal numParts 3
        , greenPetal numParts 4
        , greenPetal numParts 5
        , greenPetal numParts 6
        , greenPetal numParts 7
        ]


blueBlossom numParts =
    group
        [ bluePetal numParts 0
        , bluePetal numParts 1
        , bluePetal numParts 2
        , bluePetal numParts 3
        , bluePetal numParts 4
        , bluePetal numParts 5
        , bluePetal numParts 6
        , bluePetal numParts 7
        ]


hueBlossom numParts =
    group
        [ huePetal numParts 0
        , huePetal numParts 1
        , huePetal numParts 2
        , huePetal numParts 3
        , huePetal numParts 4
        , huePetal numParts 5
        , huePetal numParts 6
        , huePetal numParts 7
        ]


saturationBlossom numParts =
    group
        [ saturationPetal numParts 0
        , saturationPetal numParts 1
        , saturationPetal numParts 2
        , saturationPetal numParts 3
        , saturationPetal numParts 4
        , saturationPetal numParts 5
        , saturationPetal numParts 6
        , saturationPetal numParts 7
        ]


luminanceBlossom numParts =
    group
        [ luminancePetal numParts 0
        , luminancePetal numParts 1
        , luminancePetal numParts 2
        , luminancePetal numParts 3
        , luminancePetal numParts 4
        , luminancePetal numParts 5
        , luminancePetal numParts 6
        , luminancePetal numParts 7
        ]


bluePetal : Float -> Float -> Shape a
bluePetal numParts index =
    petal numParts
        |> filled (rgba 0 0 (360 * index / numParts) 1)
        |> rotateEvenly numParts index


greenPetal : Float -> Float -> Shape a
greenPetal numParts index =
    petal numParts
        |> filled (rgba 0 (360 * index / numParts) 0 1)
        |> rotateEvenly numParts index


redPetal : Float -> Float -> Shape a
redPetal numParts index =
    petal numParts
        |> filled (rgba (360 * index / numParts) 0 0 1)
        |> rotateEvenly numParts index


huePetal : Float -> Float -> Shape a
huePetal numParts index =
    petal numParts
        |> filled (hsl (360 * index / numParts) 1 0.5)
        |> rotateEvenly numParts index


saturationPetal : Float -> Float -> Shape a
saturationPetal numParts index =
    petal numParts
        |> filled (hsl 200 (index / numParts) 0.5)
        |> rotateEvenly numParts index


luminancePetal : Float -> Float -> Shape a
luminancePetal numParts index =
    petal numParts
        |> filled (hsl 200 1 (index / numParts))
        |> rotateEvenly numParts index


rotateEvenly : Float -> Float -> Shape a -> Shape a
rotateEvenly numParts index ptl =
    ptl |> rotate (degrees (360 * index / numParts))


petal : Float -> Stencil
petal numParts =
    let
        angle =
            2 * pi / numParts

        halfAngle =
            angle / 2

        size =
            30
    in
    curve ( 0, 0 )
        [ Pull ( 0, 0 ) ( size, 0 )
        , Pull ( 2 * size * cos halfAngle, 2 * size * sin halfAngle )
            ( size * cos angle, size * sin angle )
        ]
