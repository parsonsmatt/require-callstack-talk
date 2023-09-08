
import Control.Monad
import Control.Monad.Except

-- add `MonadError Int` and see what
-- happens
foo :: (Monad m) => Int -> m Char
foo i = pure (toEnum i)

bar :: (Monad m) => Int -> m [Char]
bar i = replicateM i (foo i)

main :: IO ()
main = do
    str <- bar 10
    putStrLn str





-- can either propagate constraint in the context,
-- or discharge it (with runExceptT)
