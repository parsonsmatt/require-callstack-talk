import GHC.Stack

-- QUIZ: What callstacks are printed when
--       `shouldBoom` is True vs False?

main :: IO ()
main = do
    print foo

-- Does `foo` ever appear in a CallStack?
foo :: HasCallStack => Int
foo = bar + bar

bar :: Int
bar = baz * baz

baz :: HasCallStack => Int
baz = if shouldBoom then boom else bust
  where
    shouldBoom =
        True

boom :: HasCallStack => Int
boom = error "boom"

bust :: Int
bust = error "bust"


-- load in ghci and show the stack traces for
-- boom and bust
