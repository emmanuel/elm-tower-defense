-- Look at the Blotter example first!



myShapes model =
   (List.map drawAt model.positions)
     ++
   ( if noOverlap model.positions
       then
         [ text ("You have packed in " ++ String.fromInt (List.length model.positions) ++ " red balls!")
             |> centered
             |> filled orange
             |> move (0,10)
         , text ("Try to fit 60!")
             |> centered
             |> filled orange
             |> move (0,-10)
         , rect 192 128 |> filled (rgba 0 0 0 0) |> notifyTapAt TapAt
         ]
       else
         [ text ("Oops!  You overlapped one!")
             |> centered
             |> filled orange
             |> move (10 * sin model.time, 0)
         , rect 192 128 |> filled (rgba 0 0 0 0) |> notifyTap StartAgain
         ]
   )

noOverlap positions =
  case positions of
    [] -> True -- This list is empty and we didn't find any overlaps!
    (pos1 :: rest) -> if noOverlapWith pos1 rest
                       then noOverlap rest
                       else False

-- figure out if the given center would overlap any of the balls at other positions
noOverlapWith (x,y) positions =
  case positions of
    [] -> True -- This list is empty and we didn't find any overlaps!
    ((x1,y1) :: rest) -> if (x-x1)*(x-x1) + (y-y1)*(y-y1) > 20*20
                           then noOverlapWith (x,y) rest
                           else False
-- the formula
--    (x-x1)*(x-x1) + (y-y1)*(y-y1)
-- is the square of the distance between the points (x,y) and (x1,y1)
-- The first person to use it, as far as we know, was Pythagoras, about 500 BC.

-- This function will draw a red circle at every point you tap.
-- For fun you can make it into something more fun (like a happy face).
-- Remember to use "group" to group a list of shapes into one shape.
drawAt : (Float,Float) -> Shape Msg
drawAt pos = circle 10 |> filled red |> move pos

type Msg = Tick Float GetKeyState
         | TapAt (Float,Float)
         | StartAgain

update msg model = case msg of
                     Tick t _ -> { model | time = t }
                     StartAgain -> { model | positions = [] }
                     TapAt pos -> { model | positions = pos :: model.positions }

init : { time : Float, positions : List (Float,Float) }
init = { time = 0, positions = [] }
