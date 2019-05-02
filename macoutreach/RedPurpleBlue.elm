-- This example adds one moving button and a score.


-- (1) define a new type with the states
type Colours = Red | Purple | Blue

-- (2) define one or more transition functions
change old = case old of
               Red    -> Purple
               Purple -> Blue
               Blue   -> Red

-- (3) add new states to the start of the game
init = { time = 0
       , colour = Red  -- this is the starting colour
       , score = 0     -- this is the starting score
       }

-- (4) use the new state to change how the game looks
--     by using model.colour and model.score
myShapes model = [ text ("Hello " ++ String.fromInt model.score)
                   |> filled purple
                 , roundedRect 20 30 5
                   |> filled (myColour model.colour)
                   |> move (100 * sin model.time
                           ,50 * sin (2*model.time))
                   |> makeTransparent 0.5
-- (7) attach the new messages to shapes using notifyTap
                   |> notifyTap Click -- (2) attach message
                 ]

-- tip:  use a function to simplify colour calculations
myColour c = case c of
               Red    -> rgb 255 0 0
               Purple -> rgb 200 0 200
               Blue   -> rgb 0 0 255

-- (6) add new messages for one or more clicks
type Msg = Tick Float GetKeyState
         | Click

-- (8) change the game state when you get a click message:
update msg model = case msg of
                     Tick t _ -> { model | time = t}
                     Click    -> { model
                                 | colour = change model.colour
                                   , score = model.score + 1}
