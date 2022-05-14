module Relations where
import FamilyMember
import FamilyTree
import Data.List
import Data.Maybe



-- return a member of the family tree with the given name
get_family_member :: String -> [FamilyMember] -> Maybe FamilyMember
get_family_member name family_tree = find (\member -> name == (fullName member)) family_tree

is_father :: String -> String -> [FamilyMember] -> Bool
is_father fm1 fm2 ft = father (fromJust (get_family_member fm1 ft)) == Just fm2

is_mother :: String -> String -> [FamilyMember] -> Bool
is_mother fm1 fm2 ft = mother (fromJust (get_family_member fm1 ft)) == Just fm2

is_siblings :: String -> String -> [FamilyMember] -> Bool
is_siblings fm1 fm2 ft = mother (fromJust (get_family_member fm1 ft)) == mother (fromJust (get_family_member fm2 ft)) && father (fromJust (get_family_member fm1 ft)) == father (fromJust (get_family_member fm2 ft))

is_male :: String -> [FamilyMember] -> Bool
is_male fm1 ft = gender (fromJust (get_family_member fm1 ft)) == "male"

is_son :: String -> String -> [FamilyMember] -> Bool
is_son child member ft = (is_father child member ft || is_mother child member ft) && is_male child ft

is_daughter :: String -> String -> [FamilyMember] -> Bool
is_daughter child member ft = (is_father child member ft || is_mother child member ft) && (is_male child ft) == False

is_younger :: String -> String -> [FamilyMember] -> Bool
is_younger member1 member2 family_tree = birthDate ( fromJust (get_family_member member1 family_tree)) < birthDate ( fromJust (get_family_member member2 family_tree))

is_brother :: String -> String -> [FamilyMember] -> Bool
is_brother member1 member2 family_tree = is_siblings member1 member2 family_tree && is_male member1 family_tree

is_sister :: String -> String -> [FamilyMember] -> Bool
is_sister member1 member2 family_tree = is_siblings member1 member2 family_tree && (is_male member1 family_tree) == False

is_little_brother :: String -> String -> [FamilyMember] -> Bool
is_little_brother member1 member2 family_tree = is_brother member1 member2 family_tree && is_younger member1 member2 family_tree

-- is_big_brother :: String -> String -> [FamilyMember] -> Bool
-- is_big_brother member1 member2 family_tree = is_brother member1 member2 family_tree && (is_younger member2 member1 family_tree) == False

-- is_little_sister :: String -> String -> [FamilyMember] -> Bool
-- is_little_sister member1 member2 family_tree = is_sister member1 member2 family_tree && is_younger member1 member2 family_tree

-- is_big_sister :: String -> String -> [FamilyMember] -> Bool
-- is_big_sister member1 member2 family_tree = is_sister member1 member2 family_tree && (is_younger member2 member1 family_tree) == False

-- is_amca :: String -> String -> [FamilyMember] -> Bool
-- is_amca member1 member2 family_tree = is_brother (father get_family_member member1 family_tree) member2 family_tree



