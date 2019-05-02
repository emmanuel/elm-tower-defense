-- there are two ways to make a shape move back and forth
-- you can use the sin or cos functions which look like waves
-- (see the wave tab of ShapeCreator for lots of examples)
-- or you can round to an Int, so you can use the remainder
-- function %, which is like / for divide, except it gives the remainer
-- then you have to turn it back into a Float (with fractions) to
-- use in a move, rotate, rgb, etc.

myShapes model =
  [ circle 10
      |> filled orange
      |> move ( toFloat(round (model.time*50) |> modBy 100) - 50, 10)
  ,  circle 10
      |> filled red
      |> move ( 50 * sin (model.time), -10)
  ]

type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }
