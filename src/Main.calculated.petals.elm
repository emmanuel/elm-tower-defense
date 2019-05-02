module Main exposing (main)

import GraphicSVG exposing (..)
import GraphicSVG.App


view : Model -> Collage Msg
view model =
    let
        numParts =
            model.numParts
    in
    myCollage ( 500, 500 )
        [ blossomRow4 (coloredPetal (rgba 0.1 0.1 0.75 0.75) numParts 0) (group []) (coloredPetal (rgba 0.1 0.1 0.75 0.75) numParts 0 |> curveHelper) (group [])
            |> move ( 0, 200 )
        , blossomRow3 (hueBlossom numParts) (saturationBlossom numParts) (luminanceBlossom numParts)
            |> move ( 0, 100 )
        , blossomRow4 (redBlossom numParts) (greenBlossom numParts) (blueBlossom numParts) (alphaBlossom numParts)
            |> move ( 0, 0 )

        --, blossomRow
        --    [ dynamicBlossom numParts huePetalFunc
        --    , dynamicBlossom numParts saturationPetalFunc
        --    , dynamicBlossom numParts luminancePetalFunc
        --    ]
        --    |> move ( 0, -100 )
        --, blossomRow
        --    [ dynamicBlossom numParts redPetalFunc
        --    , dynamicBlossom numParts greenPetalFunc
        --    , dynamicBlossom numParts bluePetalFunc
        --    , dynamicBlossom numParts alphaPetalFunc
        --    ]
        --    |> move ( 0, -200 )
        , blossomRow
            [ dynamicBlossom numParts (coloringPetal proportionalHue)
            , dynamicBlossom numParts (coloringPetal proportionalSaturation)
            , dynamicBlossom numParts (coloringPetal proportionalLuminance)
            , dynamicBlossom numParts (coloringPetal proportionalHSLAlpha)
            ]
            |> move ( 0, -100 )
        , blossomRow
            [ dynamicBlossom numParts (coloringPetal proportionalRed)
            , dynamicBlossom numParts (coloringPetal proportionalGreen)
            , dynamicBlossom numParts (coloringPetal proportionalBlue)
            , dynamicBlossom numParts (coloringPetal proportionalRGBAlpha)
            ]
            |> move ( 0, -200 )

        --, hueBlossom numParts
        --    |> move ( -200, 60 )
        --, saturationBlossom numParts
        --    |> move ( -100, 60 )
        --, luminanceBlossom numParts
        --    |> move ( 0, 60 )
        ]


blossomRow1 blossom =
    group
        [ blossom |> move ( -200, 0 )
        ]


blossomRow2 blossom1 blossom2 =
    group
        [ blossom1 |> move ( -200, 0 )
        , blossom2 |> move ( -100, 0 )
        ]


blossomRow3 blossom1 blossom2 blossom3 =
    group
        [ blossom1 |> move ( -200, 0 )
        , blossom2 |> move ( -100, 0 )
        , blossom3 |> move ( 0, 0 )
        ]


blossomRow4 blossom1 blossom2 blossom3 blossom4 =
    group
        [ blossom1 |> move ( -200, 0 )
        , blossom2 |> move ( -100, 0 )
        , blossom3 |> move ( 0, 0 )
        , blossom4 |> move ( 100, 0 )
        ]


blossomRow blossoms =
    group (List.indexedMap (\i b -> b |> move ( positionForRowIndex i, 0 )) blossoms)


positionForRowIndex : Int -> Float
positionForRowIndex idx =
    toFloat (idx - 2) * 100



--rawPetal : Float -> Stencil
--rawPetal numParts =


petal : Int -> Stencil
petal numParts =
    --wedge 30 0.13
    --wedge 30 (1.0 / numParts)
    let
        angle =
            2 * pi / toFloat numParts

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


rotateEvenly : Int -> Int -> Shape a -> Shape a
rotateEvenly numParts index ptl =
    ptl |> rotate (degrees (360 * toFloat index / toFloat numParts))


luminancePetal : Int -> Int -> Shape a
luminancePetal numParts index =
    petal numParts
        |> filled (hsl 360 0.5 (toFloat index / toFloat numParts))
        |> rotateEvenly numParts index


saturationPetal : Int -> Int -> Shape a
saturationPetal numParts index =
    petal numParts
        |> filled (hsl 360 (toFloat index / toFloat numParts) 0.5)
        |> rotateEvenly numParts index


huePetal : Int -> Int -> Shape a
huePetal numParts index =
    petal numParts
        |> filled (hsl (360 * toFloat index / toFloat numParts) 0.5 0.5)
        |> rotateEvenly numParts index


coloredPetal : Color -> Int -> Int -> Shape a
coloredPetal color numParts index =
    petal numParts |> filled color |> rotate (degrees (360 * toFloat index / toFloat numParts))


coloringPetal : (Int -> Int -> Color) -> Int -> Int -> Shape a
coloringPetal colorFunc numParts index =
    petal numParts |> filled (colorFunc numParts index) |> rotate (degrees (360 * toFloat index / toFloat numParts))


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


redPetal : Int -> Int -> Shape a
redPetal numParts index =
    petal numParts
        |> filled (rgba (360 * toFloat index / toFloat numParts) 0 0 1)
        |> rotateEvenly numParts index


greenPetal : Int -> Int -> Shape a
greenPetal numParts index =
    petal numParts
        |> filled (rgba 0 (360 * toFloat index / toFloat numParts) 0 1)
        |> rotateEvenly numParts index


bluePetal : Int -> Int -> Shape a
bluePetal numParts index =
    petal numParts
        |> filled (rgba 0 0 (360 * toFloat index / toFloat numParts) 1)
        |> rotateEvenly numParts index


alphaPetal : Int -> Int -> Shape a
alphaPetal numParts index =
    petal numParts
        |> filled (rgba 10 10 255 (toFloat index / toFloat numParts))
        |> rotateEvenly numParts index


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


alphaBlossom numParts =
    group
        [ alphaPetal numParts 0
        , alphaPetal numParts 1
        , alphaPetal numParts 2
        , alphaPetal numParts 3
        , alphaPetal numParts 4
        , alphaPetal numParts 5
        , alphaPetal numParts 6

        --, alphaPetal numParts 7
        , coloredPetal (rgba 0.5 0.5 0.5 (7 / toFloat numParts)) numParts 7
        ]


dynamicBlossom numParts petalFunc =
    group (List.map (petalFunc numParts) (List.range 0 numParts))


coloredPetalFunc : (Int -> Int -> Color) -> Int -> Int -> Shape a
coloredPetalFunc colorFunc numParts idx =
    coloredPetal (colorFunc numParts idx) numParts idx


redPetalFunc : Int -> Int -> Shape a
redPetalFunc numParts idx =
    coloredPetal (proportionalRed numParts idx) numParts idx


greenPetalFunc : Int -> Int -> Shape a
greenPetalFunc numParts idx =
    coloredPetal (rgba 0 (proportionalValue 255 numParts idx) 0 1) numParts idx


bluePetalFunc : Int -> Int -> Shape a
bluePetalFunc numParts idx =
    coloredPetal (rgba 0 0 (proportionalValue 255 numParts idx) 1) numParts idx


alphaPetalFunc : Int -> Int -> Shape a
alphaPetalFunc numParts idx =
    coloredPetal (rgba 25 25 175 (proportionalValue 1 numParts idx)) numParts idx


huePetalFunc : Int -> Int -> Shape a
huePetalFunc numParts idx =
    coloredPetal (hsl (360 * toFloat idx / toFloat numParts) 0.5 0.5) numParts idx


saturationPetalFunc : Int -> Int -> Shape a
saturationPetalFunc numParts idx =
    coloredPetal (hsl 360 (toFloat idx / toFloat numParts) 0.5) numParts idx


luminancePetalFunc : Int -> Int -> Shape a
luminancePetalFunc numParts idx =
    coloredPetal (hsl 360 0.5 (toFloat idx / toFloat numParts)) numParts idx


proportionalRed : Int -> Int -> Color
proportionalRed numParts idx =
    rgba (proportionalValue 255 numParts idx) 0 0 1


proportionalGreen : Int -> Int -> Color
proportionalGreen numParts idx =
    rgba 0 (proportionalValue 255 numParts idx) 0 1


proportionalBlue : Int -> Int -> Color
proportionalBlue numParts idx =
    rgba 0 0 (proportionalValue 255 numParts idx) 1


proportionalRGBAlpha : Int -> Int -> Color
proportionalRGBAlpha numParts idx =
    rgba 100 100 100 (proportionalValue 1 numParts idx)


proportionalHue : Int -> Int -> Color
proportionalHue numParts idx =
    hsla (proportionalValue 360 numParts idx) 0.5 0.5 1


proportionalSaturation : Int -> Int -> Color
proportionalSaturation numParts idx =
    hsla 360 (proportionalValue 1 numParts idx) 0.5 1


proportionalLuminance : Int -> Int -> Color
proportionalLuminance numParts idx =
    hsla 360 0.5 (proportionalValue 1 numParts idx) 1


proportionalHSLAlpha : Int -> Int -> Color
proportionalHSLAlpha numParts idx =
    hsla 360 0.5 0.5 (proportionalValue 1 numParts idx)


proportionalValue : Float -> Int -> Int -> Float
proportionalValue scale numParts idx =
    scale * (toFloat idx / toFloat numParts)


type alias Model =
    { startTime : Float, savedTime : Float, time : Float, numParts : Int }


type Msg
    = Tick Float GraphicSVG.App.GetKeyState
    | AnimateAngle Int


main : GraphicSVG.App.GameApp Model Msg
main =
    GraphicSVG.App.gameApp Tick
        { model = init
        , update = update
        , view = view
        }


init : Model
init =
    { startTime = 0, savedTime = 0, time = 0, numParts = 8 }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick t _ ->
            { model | savedTime = t, time = t - model.startTime }

        AnimateAngle parts ->
            { model | numParts = parts, startTime = model.savedTime, time = 0 }


myCollage dimensions shapes =
    let
        ( w, h ) =
            dimensions
    in
    collage w h shapes
