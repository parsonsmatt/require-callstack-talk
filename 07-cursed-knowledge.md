# Inner Workings of `Constraint`

Let's talk about some dumb and useless code

```haskell
foo :: (Def a, Num a) => a
foo = 
    def + def
```

When GHC is compiling this stuff,
    these constraints become *implicit parameters*,
        that GHC solves and provides *for you*

    but implicit parameters are first made explicit

```haskell
foo :: DefDict a -> NumDict a -> a
foo DefDict { def } NumDict { (+) } =
    def + def
```

Now let's consider `bar` - 

```haskell
bar :: Int
bar = foo
```

`bar` has *concretized* `foo` to have type `Int`.
    GHC does something like this:

```haskell
bar :: Int
bar = foo $(lookupDict @(Def Int)) $(lookupDict @(Num Int))
```

So,
    At runtime, 
        `foo` is *really* a function of two parameters.








The natural question for a programmer to ask:

> How can we abuse this information?










When you're really, 
    absolutely, 
        100% certain that you know what you're doing...




```haskell
import Unsafe.Coerce (unsafeCoerce)
```








The runtime representation 
    of an instance of a class with a single method 
    is the same as a `newtype` with that type.

```haskell
class Default a where
    def :: a

newtype DefaultDict a = DefaultDict { 
    def :: a 
}
```



The runtime representation
    of a value with a constraint
    is the same as a function 
        from the *runtime representation of the instance*  
        to the value

```haskell
foo :: Default a     => a

foo :: DefaultDict a -> a
```




Let us write some accursed code.

```haskell
newtype Curse a r = Curse (Default a => r)

curse :: forall a r. a -> (Default a => r) -> r
curse a withDefaultA =
    let a2r :: a -> r
        a2r = unsafeCoerce (Curse withDefaultA)
        a
```

This is a *bad idea*.

Do *not* do this for normal type classes.

It *will* break your code in deeply mysterious ways.

But, sometimes, a curse can be a blessing...






What *is* `RequireCallStack`?





Just an alias...

```haskell
type RequireCallStack = 
    (HasCallStack, RequireCallStackImpl)
```




What is `RequireCallStackImpl`?





Just an alias...


```haskell
type RequireCallStackImpl = 
    Add_RequireCallStack_ToFunctionContext_OrUse_provideCallStack
```



What is...... uhhh, *that* weird name?






An empty type class?

```haskell
class Add_RequireCallStack_ToFunctionContext_OrUse_provideCallStack
```

But if this is all *empty*, what's the point?









Remember: 
    GHC propagates *all* type classes, 
        with the exception of `HasCallStack`,
            *even empty classes*

We don't export the class, 
    and there are no instances of it,
        so how can it possibly be satisfied?

Well let's do some magic!

```haskell
newtype MagicCallStack r 
    = MagicCallStack 
        (RequireCallStackImpl => r)

provideCallStack 
    :: forall r
     . HasCallStack 
    => (RequireCallStackImpl => r) -> r
provideCallStack mkR = 
    (unsafeCoerce (MagicCallStack mkR) :: () -> r) ()
```

An empty class has the same representation as `()`.

Another way of considering this -

```haskell
unitToEmptyClassDict
    :: () -> RequireCallStackImpl_Dict
unitToEmptyClassDict =
    unsafeCoerce

constraintToExplicitParameter 
    :: (RequireCallStackImpl      => r)
    -> (RequireCallStackImpl_Dict -> r)
constraintToExplicitParameter =
    unsafeCoerce

provideCallStack
    :: HasCallStack 
    => (RequireCallStackImpl r => r)
    -> r
provideCallStack mkR = 
    let 
        func :: RequireCallStackImpl_Dict -> r
        func = constraintToExplicitParameter mkR 
        
        dict :: RequireCallStackImpl_Dict
        dict = unitToEmptyClassDict ()
    in
        func dict
```
