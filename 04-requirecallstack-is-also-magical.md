# `RequireCallStack` is slightly less magical

####                   (but still magical)



- The `RequireCallStack` constraint propagates, like
    `MonadError` or `MonadIO` or virtually any other
    constraint in Haskell

- So you either propagate the constraint to all 
    callsites, or you discharge it then and there
  
- But how is it implemented?


- Cursed inspiration:
    Edsko de Vries 
        "Lightweight Checked Exceptions"
        https://gist.github.com/edsko/f3d7f4e32085501fedc9

    Edward Kmett
        `reflection`
        https://hackage.haskell.org/package/reflection
