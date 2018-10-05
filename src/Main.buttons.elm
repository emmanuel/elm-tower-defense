module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = 0, update = update, view = view }


type Msg
    = Increment
    | Decrement
    | BigIncrement
    | BigDecrement
    | BiggerIncrement
    | BiggerDecrement
    | EvenBiggerIncrement
    | EvenBiggerDecrement


update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        BigIncrement ->
            model + 10

        BigDecrement ->
            model - 10

        BiggerIncrement ->
            model + 100

        BiggerDecrement ->
            model - 100

        EvenBiggerIncrement ->
            model + 1000

        EvenBiggerDecrement ->
            model - 1000


view model =
    div []
        [ div [] [ button [ onClick EvenBiggerIncrement ] [ text "+1000" ] ]
        , div [] [ button [ onClick BiggerIncrement ] [ text "+100" ] ]
        , div [] [ button [ onClick BigIncrement ] [ text "+10" ] ]
        , div [] [ button [ onClick Increment ] [ text "+" ] ]
        , div [] [ text (String.fromInt model) ]
        , div [] [ button [ onClick Decrement ] [ text "-" ] ]
        , div [] [ button [ onClick BigDecrement ] [ text "-10" ] ]
        , div [] [ button [ onClick BiggerDecrement ] [ text "-100" ] ]
        , div [] [ button [ onClick EvenBiggerDecrement ] [ text "-1000" ] ]
        ]
