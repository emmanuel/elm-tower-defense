myShapes model = [ circle 20
                    |> filled (if model.button == Blue
                                 then blue
                                 else red
                              )
                    |> notifyTap ButtonTapped
                 ]

type States = Blue | Red

type Msg = Tick Float GetKeyState
         | ButtonTapped

update msg model = case msg of
                     Tick t _ -> { model
                                 | time = t }
                     ButtonTapped
                       -> { model
                          | button =
                              case model.button of
                                Red -> Blue
                                Blue -> Red
                          }

init = { time = 0, button = Red }
