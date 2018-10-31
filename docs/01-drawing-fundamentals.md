# How can I even draw?

First, there ought (eventually, perhaps aspirationally) to be multiple pathways
for entering into this story. At the moment, there is but this first one: the
nerd-core brain-crushing skull-bender path. Buckle up.

If you look in the source code of the library we're using for drawing [you
will find](https://github.com/MacCASOutreach/graphicsvg/blob/b737953a36d94874721573eed27bc21c67116836/src/GraphicSVG.elm):

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

* `line : ( Float, Float ) -> ( Float, Float ) -> Stencil`
* `polygon : List ( Float, Float ) -> Stencil`
* `openPolygon : List ( Float, Float ) -> Stencil`
* `ngon : Int -> Float -> Stencil`
* `triangle : Float -> Stencil`
* `rightTriangle : Float -> Float -> Stencil`
* `isosceles : Float -> Float -> Stencil`
* `sideAngleSide : Float -> Float -> Float -> Stencil`
* `square : Float -> Stencil`
* `rect : Float -> Float -> Stencil`
* `rectangle : Float -> Float -> Stencil`
* `roundedRect : Float -> Float -> Float -> Stencil`
* `circle : Float -> Stencil`
* `oval : Float -> Float -> Stencil`
* `wedge : Float -> Float -> Stencil`

*sigh*. That's still pretty dense. Let's break that down. First, you may want
to read about [how to read type
signatures](./99-how-to-read-type-signatures.md). Second, we can simplify
things a bit, in order to better see what's going on here. The first
simplification is to notice that all of the signatures end with `-> Stencil`,
which tells us that all of these functions return something that is of the
`Stencil` type. Here's what the list looks like without the `-> Stencil` part:

* `circle        : Float`
* `square        : Float`
* `triangle      : Float`
* `isosceles     : Float -> Float`
* `oval          : Float -> Float`
* `rect          : Float -> Float`
* `rectangle     : Float -> Float`
* `rightTriangle : Float -> Float`
* `wedge         : Float -> Float`
* `sideAngleSide : Float -> Float -> Float`
* `roundedRect   : Float -> Float -> Float`
* `line          : ( Float, Float ) -> ( Float, Float )`
* `polygon       : List ( Float, Float )`
* `openPolygon   : List ( Float, Float )`
* `ngon          : Int -> Float`

I also took the liberty of lining things up and reordering. Hopefully that
makes this a bit more readable. At this point, everything on the right-hand
side of the colon describes the arguments that we have to supply in order to
call (aka "use", "invoke") this function. And they're ordered based on how
many arguments the function requires (this is called it's "arity". As in,
"the function `circle` has arity one.").

**IMPORTANT**: none of these function signatures tell us what the argument(s)
_mean_. In other words, `circle : Float -> Stencil` tells us that we need to
give a `Float` and we'll get a `Stencil`, but it doesn't explain what the
`Float` is for, as in how it is used to define the shape. 

But with a little bit of reflection, I think we can figure out what the
numbers mean. Let's start with the functions that only take one argument:
`circle`, `square`, `triangle`. If we define a circle, using only one number
(our `Float`), what would be the most important thing to define? I would say
"it's size", which, in math, we typically describe in terms of its radius.
So when we provide a `Float` when calling `circle`, that `Float` is used to
define the radius of the resulting circle. In the case of `square` and
`triangle`, the `Float` we provide is used to define the length of a side. 

Now, I know that `circle`'s `Float` is a radius, and `square`'s `Float` is a
side length because I've read the documentation[1], and used them in a
program. But (usually) I *don't remember* them. Instead, when I see the
function signature I go through the thought process I described above: I
consider "what could this `Float` mean?", and (often) I can quickly figure
it out based on how the shape is defined (i.e., in math, a circle is defined
by its radius).


[1] The programmer documentation of the drawing library [is
here](https://package.elm-lang.org/packages/MacCASOutreach/graphicsvg/latest/GraphicSVG#stencils)
