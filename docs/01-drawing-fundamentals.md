# How can I even draw?

First, there ought (eventually, perhaps aspirationally) to be multiple pathways
for entering into this story. At the moment, there is but this first one: the
nerd-core brain-crushing skull-bender path. Buckle up.

If you look in the [source
code](https://github.com/MacCASOutreach/graphicsvg/tree/elm-nineteen) of the
[library we're using for
drawing](https://package.elm-lang.org/packages/MacCASOutreach/graphicsvg/latest/GraphicSVG)
[you will find](https://github.com/MacCASOutreach/graphicsvg/blob/b737953a36d94874721573eed27bc21c67116836/src/GraphicSVG.elm#L1-L18):

```elm
module GraphicSVG exposing
    ( Stencil, Shape, Collage, GraphicSVG
    , collage, mapCollage
    , App, app
    , line, polygon, openPolygon, ngon, triangle, rightTriangle, isosceles, sideAngleSide, square, rect, rectangle, roundedRect, circle, oval, wedge
    , filled, outlined, repaint, addOutline, rgb, rgba, hsl, hsla
    , group
    , html
    , curve, Pull(..), curveHelper
    , LineType, solid, dotted, dashed, longdash, dotdash, custom
    , text, size, bold, italic, underline, strikethrough, centered, selectable, sansserif, serif, fixedwidth, customFont
    , move, rotate, scale, scaleX, scaleY, mirrorX, mirrorY
    , clip, union, subtract, outside, ghost
    , notifyTap, notifyTapAt, notifyEnter, notifyEnterAt, notifyLeave, notifyLeaveAt, notifyMouseMoveAt, notifyMouseDown, notifyMouseDownAt, notifyMouseUp, notifyMouseUpAt, notifyTouchStart, notifyTouchStartAt, notifyTouchEnd, notifyTouchEndAt, notifyTouchMoveAt
    , makeTransparent, addHyperlink, puppetShow
    , graphPaper, graphPaperCustom, map
    , Color, black, blank, blue, brown, charcoal, darkBlue, darkBrown, darkCharcoal, darkGray, darkGreen, darkGrey, darkOrange, darkPurple, darkRed, darkYellow, gray, green, grey, hotPink, lightBlue, lightBrown, lightCharcoal, lightGray, lightGreen, lightGrey, lightOrange, lightPurple, lightRed, lightYellow, orange, pink, purple, red, white, yellow
    )
```

Whuhhh?!?! That's pretty dense. Let's break it down. First thing is the
`Stencil` types. These are the raw ("primitive") shapes that can be expressed.
They are listed by name in the section above. Lower down, spread out in the
code, you will find the type signatures for all of these functions. Here
they are, collected together:

```elm
line : ( Float, Float ) -> ( Float, Float ) -> Stencil
polygon : List ( Float, Float ) -> Stencil
openPolygon : List ( Float, Float ) -> Stencil
ngon : Int -> Float -> Stencil
triangle : Float -> Stencil
rightTriangle : Float -> Float -> Stencil
isosceles : Float -> Float -> Stencil
sideAngleSide : Float -> Float -> Float -> Stencil
square : Float -> Stencil
rect : Float -> Float -> Stencil
rectangle : Float -> Float -> Stencil
roundedRect : Float -> Float -> Float -> Stencil
circle : Float -> Stencil
oval : Float -> Float -> Stencil
wedge : Float -> Float -> Stencil
```

*sigh*. That's still pretty dense. Let's break that down. First, you may want
to read about [how to read type
signatures](./99-how-to-read-type-signatures.md). Second, we can simplify
things a bit, in order to better see what's going on here. The first
simplification is to notice that all of the signatures end with `-> Stencil`,
which tells us that all of these functions return something that is of the
`Stencil` type. Here's what the list looks like without the `-> Stencil` part:

```elm
circle        : Float
square        : Float
triangle      : Float
isosceles     : Float -> Float
oval          : Float -> Float
rect          : Float -> Float
rectangle     : Float -> Float
rightTriangle : Float -> Float
wedge         : Float -> Float
sideAngleSide : Float -> Float -> Float
roundedRect   : Float -> Float -> Float
line          : ( Float, Float ) -> ( Float, Float )
polygon       : List ( Float, Float )
openPolygon   : List ( Float, Float )
ngon          : Int -> Float
```

I also took the liberty of lining things up and reordering. Hopefully that
makes this a bit more readable. At this point, everything on the right-hand
side of the colon describes the arguments that we have to supply in order to
call (aka "use", "invoke") this function. And they're ordered based on how
many arguments the function requires.

**IMPORTANT**: none of these function signatures tell us what the
argument(s) _mean_. In other words, `circle : Float -> Stencil` tells us
that, in order to use the `circle` function, we need to give a `Float` and
we'll get a `Stencil`, but it doesn't explain what the `Float` is for, as in
how it is used to define the shape.

But with a little bit of reflection, I think we can figure out what the
numbers mean. Let's start with the functions that only take one argument:
`circle`, `square`, `triangle`. If we define a circle, using only one number
(our `Float`), what would be the most important thing to define? I would say
"it's size", which, in math, we typically describe in terms of its radius.
So when we provide a `Float` when calling `circle`, that `Float` is used to
define the radius of the resulting circle. In the case of `square` and
`triangle`, the `Float` we provide is used to define the length of a side;
one number is sufficient to define a square or triangle, because squares and
triangles _by definition_ have sides of the same length (one number!). So
the mathematical definition of the shape is our big(gest) clue about to use
the function of the same name. 

Now, I left something out of the description above: not **all** triangles
have equal side lengths; _equilateral_ triangles do. So we can infer that
the `triangle` function is going to give us an _equilateral_ triangle; we
know this because other kinds of triangles can't be defined with a single
number ("need more input. does not compute."). And we've got one more clue:
there are other kinds of triangle functions in the list. The second kind of
triangle (after equilateral) is _isoceles_, which is a triangle where two
sides have the same length. The `isoceles` function takes two `Float`s:
first `Float` is the length of the two same-length sides, and second `Float`
is the length of the 'other' side. The second kind of triangle is a _right
triangle_, which can be described in terms of the lengths of its two legs.
And based on that description, you can see that `rightTriangle` needs two
`Float`s, which define the lengths of its sides. There are other ways you
could define a _right triangle_ (e.g., you could define it by its angles),
so it's only by reading the documentation (and trying it out!) that I know
how these numbers are used to define shapes.

Now, I know that `circle`'s `Float` is a radius, and `square`'s `Float` is a
side length because I've read the documentation[1], and used them in a
program. But (usually) I _don't remember_ them. Instead, when I see the
function signature I go through the thought process I described above: I
consider "what could this `Float` mean?", and (often) I can quickly figure
it out based on how the shape is defined (i.e., in math, a circle is defined
by its radius).


[1] The programmer documentation of the drawing library [is
here](https://package.elm-lang.org/packages/MacCASOutreach/graphicsvg/latest/GraphicSVG#stencils)
