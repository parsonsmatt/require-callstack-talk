import GHC.Stack

-- Desugaring `HasCallStack` into explicit parameters

main :: IO ()
main = do
    print $ foo $(mkCallStack)

-- Does `foo` ever appear in a CallStack?
foo :: CallStack -> Int
foo callStack = bar + bar

bar :: Int
bar = baz $(mkCallStack) * baz $(mkCallStack)

baz :: CallStack -> Int
baz callStack = if shouldBoom then boom callStack else bust
  where
    shouldBoom =
        True

boom :: CallStack -> Int
boom callStack = error callStack "boom"

bust :: Int
bust = error $(mkCallStack) "bust"


-- load in ghci and show the stack traces for
-- boom and bust

