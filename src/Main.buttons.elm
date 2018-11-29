module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = init, update = update, view = view }


type Msg
    = Reset
    | Increment
    | Decrement
    | BigIncrement
    | BigDecrement
    | BiggerIncrement
    | BiggerDecrement
    | EvenBiggerIncrement
    | EvenBiggerDecrement


type alias Model =
    { counter : Int }


init : Model
init =
    { counter = 0 }


update msg model =
    case msg of
        Reset ->
            { model | counter = 0 }

        Increment ->
            { model | counter = model.counter + 1 }

        Decrement ->
            { model | counter = model.counter - 1 }

        BigIncrement ->
            { model | counter = model.counter + 10 }

        BigDecrement ->
            { model | counter = model.counter - 10 }

        BiggerIncrement ->
            { model | counter = model.counter + 100 }

        BiggerDecrement ->
            { model | counter = model.counter - 100 }

        EvenBiggerIncrement ->
            { model | counter = model.counter + 1000 }

        EvenBiggerDecrement ->
            { model | counter = model.counter - 1000 }


view model =
    div []
        [ div [] [ button [ onClick EvenBiggerIncrement ] [ text "+1000" ] ]
        , div [] [ button [ onClick BiggerIncrement ] [ text "+100" ] ]
        , div [] [ button [ onClick BigIncrement ] [ text "+10" ] ]
        , div [] [ button [ onClick Increment ] [ text "+" ] ]
        , div []
            [ text (String.fromInt model.counter)
            , button [ onClick Reset ] [ text "Reset" ]
            ]
        , div [] [ button [ onClick Decrement ] [ text "-" ] ]
        , div [] [ button [ onClick BigDecrement ] [ text "-10" ] ]
        , div [] [ button [ onClick BiggerDecrement ] [ text "-100" ] ]
        , div [] [ button [ onClick EvenBiggerDecrement ] [ text "-1000" ] ]
        ]
