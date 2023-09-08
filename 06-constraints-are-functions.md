# Classes are Functions,
# - ~ - ~ - ~ - ~ - ~ - 
# Constraints are Values

- Yeah, yeah, I know, this is Haskell,
    everything is a ~*~ function ~*~

- `Constraint` is special kind of value, 
    solved and passed implicitly,
        and require magic incantation to use

- A type class is a *function* 
    from a `Type` to a `Constraint`

  The `Default` class is the simplest demonstration:

```haskell
class Default a where
    def :: a

instance Default Int where
    def = 0
```

So what happens when you write this?

```haskell
main :: IO ()
main = do
    print (def @Int)
```

Well, that sure *looks* like we're passing in a type,
    and we're getting back an `Int` 
                that we can `print`

When GHC compiles this code, 
    that's basically exactly what is happening!

GHC does an instance search for `Default Int`,
    finds it,
        and uses *that* specific value

So `Default` is a *function* 
    that accepts a type 
    and returns a `Constraint`, 
        and `def` is the magic invocation 
            that accesses the `Constraint`


Inspiration:

    - Gabriella Gonzalez
        "Scrap Your Type Classes"
        https://www.haskellforall.com/2012/05/scrap-your-type-classes.html
