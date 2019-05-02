-- snake game

myShapes model = [
                    graphPaper 10 |> move (-5,-5)
                 ,  renderSnake model.snake
                 ,  circle 4 |> filled red |> move (toFloat <| (Tuple.first model.food) * 10, toFloat <| (Tuple.second model.food) * 10)
                 ,  text "Change snake direction with the arrow keys." |> size 5|> centered |> filled black |> move (0,54)
                 ]

renderSnake snake = group <| List.map (\(x,y) -> roundedRect 8.5 8.5 2
                                                    |> filled darkGray
                                                    |> move (toFloat x * 10, toFloat y * 10)
                                                    ) snake
type Msg = Tick Float GetKeyState

type Direction =
  Up | Down | Left | Right

update msg model = case msg of
                     Tick t (_,(x,y),_) ->
                       let
                         newModel = { model | time = t, direction = updateDirection (x,y) model.direction }
                       in
                         if (model.time - model.lastTime) > 1 / sps then
                            updateSnake newModel
                         else newModel
updateSnake model =
  let
    (shx,shy) = case (List.head model.snake) of
                  Just (sx,sy) -> (sx,sy)
                  Nothing -> (0,0)
    (nhx,nhy) = case model.direction of
                  Left  -> (shx - 1, shy)
                  Right -> (shx + 1, shy)
                  Up    -> (shx, shy + 1)
                  Down  -> (shx, shy - 1)
    snakeTail = if (shx,shy) == model.food then
                  model.snake
                else
                 (List.take (List.length model.snake-1) model.snake)
    newFood = if (shx,shy) == model.food then
                (ceiling (5*sin (model.time * 100)), ceiling (5*cos (model.time * 100)))
              else model.food
  in
    if List.member (nhx,nhy) snakeTail then init else
    { model | snake = (nhx,nhy)::snakeTail
            , lastTime = model.time
            , food = newFood
            }

updateDirection : (Float,Float) -> Direction -> Direction
updateDirection (x,y) oldDir =
  case (round <| x+1,round <| y+1,oldDir) of
    (0,_,Up)   -> Left
    (0,_,Down) -> Left
    (2,_,Down)  -> Right
    (2,_,Up)    -> Right
    (_,0,Left) -> Down
    (_,0,Right)-> Down
    (_,2,Left) -> Up
    (_,2,Right)-> Up
    _      -> oldDir

sps = 3 --squares per second

init = { time = 0
       , lastTime = 0
       , snake = [(0,0),(-1,0),(-2,0),(-3,0),(-4,0)]
       , direction = Right
       , food = (-5,-5)
       }
