-- @author Laura Viglioni
-- 2019
-- GNU General Public License v3.0 

-- :gb:
-- Fermat's algorithm to test primality
-- This is a probabilistic algorithm
-- False means it is NOT a prime
-- True means it probably is prime
-- First parameter is a integer to be tested
-- The second is how many times it must be tested

-- 🇧🇷
-- Algoritmo de Fermat para testar primalidade
-- É um algoritmo probabilístico
-- False significa que o número NÃO é primo
-- True significa que o número provavelmente é primo
-- O primeiro parâmetro é um inteiro a ser testado
-- O segundo é quantas vezes ele deve ser testado

-- fermat_test
-- @param prime (integer)
-- @param repeat (integer)
-- @return is_prime (Bool)

module Fermat where

import System.Random
import ModularExp

test_pure :: (Integral t, Random t) => t -> [t] -> Bool
test_pure prime arr = is_prime
  where
    booleans = map (\a -> unitary_test prime a) arr
    is_prime = foldl (&&) True booleans

fermat_test :: (Integral t, Random t) => t -> t -> IO Bool
fermat_test prime repeat =
  do
    seed <- newStdGen
    return $ fermat_aux prime repeat seed 1 True


fermat_aux :: (Integral t, RandomGen g, Random t) => t -> t -> g -> t -> Bool -> Bool
fermat_aux 2 _ _ _ _ = True
fermat_aux prime repeat seed counter acc =
  if prime < 2 then False
  else
    if counter <= repeat && acc 
    then fermat_aux prime repeat new_seed (counter+1) test
    else acc
  where
    (a,new_seed) = randomR (2, (prime-1)) seed
    test = acc && unitary_test prime a

unitary_test :: (Integral a, Random a) => a -> a -> Bool
unitary_test prime a
  | mod_exp a (prime-1) prime == 1 = True
  | otherwise = False

