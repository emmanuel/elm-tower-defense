myShapes model = [ 
                   --If the player hasn't lost yet, show the game screen
                   --Otherwise, show the Game Over screen
                   if model.playing then 
                    group [
                            rect 192 128 |> filled lightGreen
                          , road
                          , player
                              |> scale 2
                              |> move model.playerPosition
                          , car red
                              |> move (car1Position model)
                          , car blue
                              |> move (car2Position model)
                          , car green
                              |> move (car3Position model)
                          ]
                   else 
                     --Change how the lose screen looks
                     group [
                             text "Game Over!! Try again!" |> centered |> filled red
                           ]
                 ]
                 

--The initial state of the game
init = { time = 0, playerPosition = (0,0), playing = True }


road = group [ rect 200 90
                          |> filled darkGray
             , rect 200 70
                          |> filled black
             , rect 200 23.3
                          |> outlined (dashed 5) yellow
             ]
             
--Define your car here. You can use the colour variable in order
--to easily change the colour of the car in your game
car colour = 
  group [ 
           roundedRect 40 23 3 |> filled colour
        ]
            
--This is the player, you can change how it looks here
player =
  group [
           circle 7 |> filled red
        ]

--These functions determine how the cars move
--Try changing their movement patterns by editing these!
car1Position model = (500*cos (0.3*model.time) ,  0)
car2Position model = (1300*cos (0.2*model.time), 23)
car3Position model = (1000*cos (0.1*model.time),-23)

type Msg = Tick Float GetKeyState

update msg model = case msg of
                     Tick t (_,(x,y),_) -> 
                       let
                         --Get the old position from the model, and split it into 
                         --its x and y components
                         (oldPlayerX,oldPlayerY) = model.playerPosition
                         newPlayerX = oldPlayerX + x
                         -- Don't let the player go off the road
                         newPlayerY = if oldPlayerY > 30 then 
                                         30 
                                      else if oldPlayerY < -30 then 
                                         -30
                                      else oldPlayerY + y
                       in
                         { model | time = t
                         , playerPosition = (newPlayerX,newPlayerY)
                         , playing = 
                             let
                               --Get the three cars' positions
                               (car1x,car1y) = car1Position model
                               (car2x,car2y) = car2Position model
                               (car3x,car3y) = car3Position model
                             in
                               --Detect if the player is too close to a car
                               --If they are, then end the game by setting
                               --"playing" to False. Otherwise, keep it the
                               --same state as before.
                               if abs (newPlayerY - car1y) <= 11.5 
                               && abs (newPlayerX - car1x) < 10 then 
                                  False 
                               else if abs (newPlayerY - car2y) <= 11.5 
                                    && abs (newPlayerX - car2x) < 10 then
                                  False
                               else if abs (newPlayerY - car3y) <= 11.5 
                                    && abs (newPlayerX - car3x) < 10 then
                                  False
                               else model.playing
                        }
			