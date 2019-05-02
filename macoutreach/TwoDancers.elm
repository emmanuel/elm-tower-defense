-- two dancers

-- This examples uses properties of the functions sin (called sine) and cos (called cosine) 
-- which you can understand if you go to wave tab of the ShapeCreator.
-- (cos time) and (sin time) are the (x,y) coordinates of a point going
-- around a circle.
-- So if you want to have shapes look like they are dancing around each other,
-- think about sitting at the side of the circle on the wave tab.
-- The shapes go back and forth according to the sin function
-- while the distance from you depends on the cos funnction.
-- You can make things look closer or farther using scale, 
-- and the position side-to-side comes from the move.
-- That leaves one tricky point:  when something is farther away,
-- it should be drawn first so it gets hidden, and does not hide the other shape.
-- You can do this by checking whehter (cos model.time) is positive or negative,
-- and changing the order of the shapes.
myShapes model = 
  if cos model.time < 0 
    then
      [dancer darkBlue
          |> move (sin model.time*100 ,0)
          |> scale (1 + 0.5 * cos model.time)
      ,dancer lightBlue
          |> move (sin -model.time*100 ,0)
          |> scale (1 - 0.5 * cos model.time)
      ]
    else
      [dancer lightBlue
          |> move (sin -model.time*100 ,0)
          |> scale (1 - 0.5 * cos model.time)
      ,dancer darkBlue
          |> move (sin model.time*100 ,0)
          |> scale (1 + 0.5 * cos model.time)
      ]

-- so that we can change the colour of your shape, we make it
-- a function with one input, clr (short for colour)
dancer clr  = group 
  [ circle 60
     |> filled clr 
  ]


init = { time = 0  }

type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t _
                       ->  { model
                           | time = t
                           }
