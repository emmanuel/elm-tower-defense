-- Keyboard control for two paddles

-- paddles in games usually have no inertia to move like ping-pong paddles
-- their mass is very low compared to the power in arm muscles
init = { time = 0 , posL = 0, posR = 0 }

-- we don't need to use any notifyTap or notifyTapAt in this type of game
myShapes model = [ drawPaddle (rgb 255 0 0) -90 model.posL
                 , drawPaddle (rgb 0 0 255) 90 model.posR
                 ]

-- nor do we need any new messages
type Msg = Tick Float GetKeyState

-- since we will have two paddles which look alike, we will use will make a
-- function to draw them, which takes the colour as an input
drawPaddle clr xPos yPos =
  group [ rect 3 20 |> filled clr
        ]
    |> move (xPos,yPos)

-- the update function records the time (in case we want animations)
update msg model = case msg of
                     Tick t (_,(_,dirR),(_,dirL))
                       ->  { model
                           | time = t
                           , posL = dirL + model.posL
                           , posR = dirR + model.posR
                           }
