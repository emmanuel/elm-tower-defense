-- Adapted from: http://www.cas.mcmaster.ca/~anand/examples/AngularPetals.elm


module Main exposing (main, view)

import GraphicSVG exposing (..)
import GraphicSVG.App


main =
    GraphicSVG.App.gameApp Tick
        { model = init
        , update = update
        , view = view
        }


view model =
    collage 500
        500
        [ myShapes model

        --|> rotate (degrees -5)
        ]


myShapes model =
    let
        indices =
            List.map toFloat <| List.range 0 (model.numParts - 1)

        numParts =
            model.numParts
    in
    group
        ([ square 100 |> filled black ]
            ++ List.map2 (\shape angle -> shape |> rotate (degrees angle))
                (List.map (petal <| toFloat numParts) indices)
                (List.map
                    (\x ->
                        (if model.time < 5 then
                            0.2 * model.time - (toFloat <| floor (0.2 * model.time))

                         else
                            1
                        )
                            * (360 / toFloat numParts)
                            * x
                    )
                    indices
                )
            ++ (if model.time > 5 then
                    List.map showAngle <| List.map (\x -> 360 / toFloat numParts * x) indices

                else
                    []
               )
            ++ [ button 2 |> move ( 60, 45 )
               , button 3 |> move ( 60, 27 )
               , button 4 |> move ( 60, 9 )
               , button 6 |> move ( 60, -9 )
               , button 8 |> move ( 60, -27 )
               , button 12 |> move ( 60, -45 )
               ]
        )


petal parts index =
    let
        angle =
            2 * pi / parts

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
        |> filled (hsl (360 * index / parts) 1 0.5)


showAngle angle =
    group [ text (Debug.toString angle) |> size 6 |> filled white |> move ( 40, -2 ) ] |> rotate (degrees angle)


button parts =
    group
        [ roundedRect 15 10 3 |> filled (rgb 200 0 0) |> notifyTap (AnimateAngle parts)
        , text (Debug.toString parts) |> centered |> size 8 |> filled white |> move ( 0, -3 ) |> notifyTap (AnimateAngle parts)
        ]


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
    { startTime = 0, savedTime = 0, time = 0, numParts = 0 }
