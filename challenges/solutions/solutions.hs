module MyList where

{-
A list: A list (whose elements has type t) could be an empty
list [] or element with type t added to a head of a sequence
of t typed elements.
-}

data MyList a = Cons a (MyList a) 
              | Nil deriving (Show, Eq)

{-
TESTING LISTS
-}
-- [1,2,3,4,5,6,7,8,9,0]
l1 = Cons 1 $ Cons 2 $ Cons 3 $ Cons 4 $ Cons 5 $ Cons 6 $ Cons 7 $ Cons 8 $ Cons 9 $ Cons 0 $ Nil

-- [9,1,2,8,3,4,7,6,5,0]
l2 = Cons 9 $ Cons 1 $ Cons 2 $ Cons 8 $ Cons 3 $ Cons 4 $ Cons 7 $ Cons 6 $ Cons 5 $ Cons 0 $ Nil

--
l3 = Cons 90 $ Cons 91 $ Cons 102 $ Cons 81 $ Cons 3 $ Cons 104 $ Cons 1007 $ Cons 96 $ Cons 50 $ Cons 1000 $ Nil


-- []
l4 = Nil


-- Auxiliary Functions

{- Implement a function that, ginven a MyList, returns the first element.
If Nil MyList is given, returns Nil
-}
myHead :: MyList a -> a
myHead (Cons a _ ) = a

{- Implement a function that, given a MyList, returns the whole MyList but the first elemt.
Ignore the Nil MyList case
-}
myTail :: MyList a -> MyList a
myTail (Cons a b) = myTail' b where
  myTail' Nil = Nil
  myTail' (Cons a b) = Cons a (myTail' b)

{- Implement a function that, given a MyList, returns the whole MyList but the last element.
Ignore the Nil MyList case
-}
myInit :: MyList a -> MyList a
myinit (Cons _ Nil) = Nil
myInit (Cons a b) = Cons a (myTail b)


{- implement a function that, given a MyList, returns the very last element.
Ignore the Nil MyList case.
-}
myLast :: MyList a -> a
myLast (Cons a Nil) = a
myLast (Cons _ b) = myLast b 

{- implement a function that, given a MyList of t elements and a elemtn of type t,
retruns a list whith the given MyList at the beginning and the element at the end
-}
myAppend :: MyList a -> a -> MyList a
myAppend Nil e = Cons e $ Nil 
myAppend (Cons a b) e = Cons a $ (myAppend b e)

{-
Implement a function that, given a MyList, returns the same list reversed.
TIP: Use myAppend function.
-}
myReverse :: MyList a -> MyList a
myReverse Nil = Nil
myReverse (Cons a b) = myAppend (myReverse b) a

{-
Implement a function that, given two MyLists, returns only one MyList which is the
Concatenation of the two MyLists given.
TIP: Use myAppend function
-}
myConcat :: MyList a -> MyList a -> MyList a
myConcat a b = myConcat' b a where
  myConcat' (Cons a Nil) acc = myAppend acc a
  myConcat' (Cons a b) acc = myConcat' b (myAppend acc a)



-- MAP

{-
Implement a function that, given a number, calculates his square
-}
square :: Num a => a -> a
square n = n * n

{-
Implement a function that, given a MyList of numbers, calculates the square of all its
elements and return them as a MyList.
TIP: Use the square function
-}
squares :: Num a => MyList a -> MyList a
squares Nil = Nil
squares (Cons a b) = Cons (square a) (squares b)

{-
Implement a function that, given a MyList of numbers, returns the same MyList with the
numbers converted to strings.
TIP: Use show function
-}
stringize :: Show a => MyList a -> MyList String
stringize Nil = Nil
stringize (Cons a b) = Cons (show a) (stringize b)

{-
myMap:
MyMap is a function that receives another function and a MyList.
What this function does is to apply the received function to each element of the
fiven MyList and returns a new MyList
-}
myMap :: (a -> b) -> MyList a -> MyList b
myMap _ Nil = Nil
myMap f (Cons a b) = Cons (f a) (myMap f b)

{-
Implement the squares function using myMap
-}
squares2 :: Num a => MyList a -> MyList a
squares2 = myMap square

{-
Implement the stringize using myMap
-}
stringize2 :: Show a => MyList a -> MyList String
stringize2 = myMap show



-- FILTER

{-
Implement a function that returns true if a given number is eve, otherwise returns false
-}
myEven :: Integral a => a -> Bool
myEven x = (x `mod` 2) == 0

{-
Implement a function that returns true if the given is greater than 100, otherwise returns
false
-}
myBig :: (Num a, Ord a) => a -> Bool
myBig x = x > 100

{-
Implement a function that, given a MyList of Numbers, returns a new MyList with only the
evens numbers.
TIP: Use the even function
-}
myEvens :: Integral a => MyList a -> MyList a
myEvens Nil = Nil
myEvens (Cons a b) = if myEven a then Cons a (myEvens b) else myEvens b

{-
Implement a function that, given a MyList of Numbers, returns a new MyList with only the
numbers bigger than 100.
TIP: Use myBig function
-}
myBigs :: (Num a, Ord a) => MyList a -> MyList a
myBigs Nil = Nil
myBigs (Cons a b) = if myBig a then Cons a (myBigs b) else myBigs b

{-
myFIlter:
myFilter is a function that receives another boolean function and a MyList.
What this function does is to apply the boolean function to each element of the
MyList given and returns a new MyList with only the elements thar satifies the
boolean function, e.i. that returns true in the boolean function.
-}
myFilter :: (a -> Bool) -> MyList a -> MyList a
myFilter _ Nil = Nil
myFilter f (Cons a b) = if f a then Cons a (myFilter f b) else (myFilter f b)

{-
Implement the myEvens funtion using myFilter
-}
myEvens2 :: MyList Integer -> MyList Integer
myEvens2 = myFilter myEven

{-
Implement the myBigs function using myFilter 
-}
myBigs2 :: MyList Integer -> MyList Integer
myBigs2 = myFilter myBig



-- FOLD

{-
Implement a function that, given a MyList, returns the length of the MyList
-}
myLength :: MyList a -> Integer
myLength Nil = 0
myLength (Cons _ b) = 1 + (myLength b)

{-
Implement a funtion that, given a MyList of numbers, returns the summatory of all numbers.
-}
mySum :: Num a => MyList a -> a
mySum Nil = 0
mySum (Cons a b) = a + (mySum b)

{-
Implement a function that, given a MyList of numbers, returns the maximum number
of the MyList.
Ignore the Nil case.
-}
myMaximum :: (Num a, Ord a) => MyList a -> a
myMaximum l = myMaximum' l 0 where
  myMaximum' Nil acc = acc
  myMaximum' (Cons a b) acc = if a > acc then myMaximum' b a else myMaximum' b acc 

{-
myFold:
myFold is a functions that receives another functiona an initial value and a MyList.
This function is pretty difficult, suppose the given function is f, what this myFold
does is to apply the function f to each element and the initial value and the result is
"stored" as a new initial value, this is waht we call "the carry". In a more procedural
way:

carry = 0
for e in MyList
    carry = f(carry, e)

return carry
-}
myFold :: (t -> t1 -> t1) -> t1 -> MyList t -> t1
myFold _ acc Nil = acc
myFold f acc (Cons a b) = myFold f (f a acc) b

{-
myFoldl:
myFoldh works similar as myFoldl but it uses the head of the MyList as initial value.
Ignore the Nil case.
TIP: Use myFold function
-}
myFoldh :: (t -> t -> t) -> MyList t -> t
myFoldh f (Cons a b) = myFold (f) a b

{-
Implement length using myFold
-}
myLength2 :: MyList a -> Integer
myLength2 = myFold (\_ x -> x + 1) 0

{-
Implement sum using myFold or myFoldh.
In case of using myFoldh, ignore the Nil case.
-}
mySum2 :: Num a => MyList a  -> a
mySum2 = myFold (+) 0

mySum2h :: Num a => MyList a  -> a
mySum2h = myFoldh (+)

{-
Implement myMaximum using myFold or myFoldh.
In case of using myFoldh, ignore the Nil case.
-}
myMaximum2 :: (Num a, Ord a) => MyList a -> a
myMaximum2 = myFold (\x acc -> if x > acc then x else acc) 0

myMaximum2h :: (Num a, Ord a) => MyList a -> a
myMaximum2h = myFoldh (\x acc -> if x > acc then x else acc)



-- TODO: Maybe!
