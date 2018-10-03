# elm-tower-defense

Teach CS with the Elm language (http://elm-lang.org), building a PvZ-ish Tower Defense

## Rough plan for this repo

For now, this is a repo for holding my experiments and explorations with the Elm language. Once I have a handle on how I'm going to break down the project into steps and stages, then I'll create branches that represent the stages that I'll have students start at.

My basic plan is to lean heavily on [the GraphicSVG library from McMaster University's CS outreach program](https://github.com/MacCASOutreach/graphicsvg), which is designed for teaching algebraic thinking to new programmers. 

With it, I plan to build up composite shapes for our characters as we learn the syntax and concepts. Then, with characters defined as composite shapes, we can move into declarative/functional animation of the characters (internal movement: walking/attacking/dying/dead), as well as movement of the characters on screen (e.g., attackers moving R-to-L).

After we've got animated characters and have gotten comfortable with manipulating simple types and functions, then we'll move on to interaction, and work out how to handle mouse and keyboard input and how to use those inputs to plant defenders, collect resources, etc.
