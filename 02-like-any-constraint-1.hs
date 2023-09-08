
import Control.Monad
import Control.Monad.IO.Class

-- add `MonadIO` and see what happens
foo :: (MonadIO m) => Int -> m Char
foo i = pure (toEnum i)

bar :: (MonadIO m) => Int -> m [Char]
bar i = replicateM i (foo i)

main :: IO ()
main = do
    str <- bar 10
    putStrLn str
