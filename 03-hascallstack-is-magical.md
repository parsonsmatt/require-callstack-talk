

#    `HasCallStack` is Magical


- `HasCallStack` is the only constraint that 
  doesn't propagate to callsites of functions

- GHC will synthesize a `CallStack` if there 
  isn't one available

- Implemented as an `ImplicitParam` with special
  GHC magic


```haskell
type HasCallStack = (?callStack :: CallStack)
```


