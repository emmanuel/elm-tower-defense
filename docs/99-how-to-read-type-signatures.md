# How to read type signatures

Type signatures are the descriptions of the types that go into and come out
of a function. They are lines of code with colons, only type signatures have
colons. For example:

```elm
circle : Float -> Stencil
```

You could read the above signature as 'a function called "circle", which
accepts one argument, a Float, and returns a Stencil.' And you
would call this function like:

```elm
circle 25
```

And because `circle` returns a stencil, you would need to do a little more to
draw it:

```elm
circle 25
  |> outlined (solid 1) black
```

And that is because a `Stencil` can not be directly drawn on-screen; to do so
you must convert the `Stencil` into a `Shape`, which basically means explaining
what color (if `filled`) or line style and color (if `outlined`).


## More complex type signatures

You will encounter more complex type signatures. Fear not!

They all follow the same formula, and with methodical application of a few
simple rules, you can decode even the most arcane and forboding type signature.
The gorgon fears you!

Behold the mighty `line`:

```elm
line : ( Float, Float ) -> ( Float, Float ) -> Stencil
```

You may ask, "what in tarnation does that gobbledygook mean?". I hope you do!
Let me tell you. You could read the above signature as 'a function called
"line", which accepts two arguments, each a pair of Floats, and returns a
Stencil.' Which I would expect you to tell me is about as clear as mud. Let's
take a small step back; why are we interested in type signatures in the first
place? It's because they let us know exactly what we must provide and what
we'll get back when calling functions. In other words, they describe how the
pieces of your program have to be fit together to work. And maybe that's a
little closer to making sense, but it didn't really sink in for me until I
saw how it looks in practice.

And you would call `line` like this:

```elm
line ( 0, 99.12 ) ( 40, 305 )
```

Any guesses about what the two `( Float, Float )` arguments are?

.

.

.

.

.

...

Alright, I'll tell you. They are points in a 2-d plane: a pair of `Float`[1]
(x, y) values. And a `line` takes a pair of these points (remember: `line : (
Float, Float ) -> ( Float, Float ) -> Stencil`): the first point is where the
line starts, and the second point is where it ends. In other words, every
line starts somewhere and stops somewhere else, and to draw one, that's what
you have to describe.

FYI: because `line` returns a `Stencil`, you would need to do a little more
to draw it:

```elm
line ( 0, 99.12 ) ( 40, 305 )
  |> outlined (solid 1) black
```

With the above code, we've described where to start and where to end (`line
(0, 99.12) (40, 305)`), and then how to draw it (`outlined (solid 1) black`).


[1] The `Float` type is a floating point number, which (basically) means that
it can handle decimal values, and not solely whole numbers (which is what
`Int` is for).
