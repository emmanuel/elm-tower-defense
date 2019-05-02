-- Keyboard control for two paddles

-- paddles in games usually have no inertia to move like ping-pong paddles
-- their mass is very low compared to the power in arm muscles
init = { time = 0 , paddle = 0 }

-- we don't need to use any notifyTap or notifyTapAt in this type of game
myShapes model = [ drawPaddle (rgb 255 255 0) model.paddle
                 ]

-- nor do we need any new messages
type Msg = Tick Float GetKeyState

-- position of paddle on Screen
yPaddle = -60

-- since we will have two paddles which look alike, we will use will make a
-- function to draw them, which takes the colour as an input
drawPaddle clr xPos =
  group [ rect 20 3 |> filled clr
        ]
    |> move (xPos,yPaddle)

-- the update function records the time (in case we want animations)
update msg model = case msg of
                     Tick t (_,(dir,_),_)
                       ->  { model
                           | time = t
                           , paddle = dir + model.paddle
                           }
