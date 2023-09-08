# What are constraints even??!

- A `Constraint` is a thing in Haskell 
  that shows up on the left of a fat arrow

```haskell
foo :: Constraint => Type
```

- You can define them with `class` keyword

```haskell
class Blah a where
    blah :: a -> a
```

- Type classes are the most common constraints 
  in Haskell, but they're not the only ones:

  - Equality constraints: `(a ~ b)`
  - Implicit Parameters
  - `TypeError`
