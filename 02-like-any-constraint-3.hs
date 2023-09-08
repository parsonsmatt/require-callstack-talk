import RequireCallStack
import GHC.Stack

main :: IO ()
main = do
    print foo

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

-- change `bust` to `errorRequireCallStack`
-- try out propagating and discharging the constraint
