module FamilyTree where
import Data.List
import Data.Maybe
import FamilyMember 

data FamilyTree = FamilyTree {
    treeName :: String,
    treeMembers :: [FamilyMember],
    treeRoot :: Maybe String
} deriving (Show)

-- return a member of the family tree with the given name
get_family_member :: String -> [FamilyMember] -> Maybe FamilyMember
get_family_member name family_tree = find (\member -> name == (fullName member)) family_tree

remove element list = filter (\e -> e/=element) list

updateFather :: FamilyTree -> String -> String -> Maybe String -> FamilyTree
updateFather tree ol child Nothing = tree
updateFather ft old child (Just fatherName) = do
    let father = fromJust (get_family_member fatherName (treeMembers ft))
    let removedChildren = remove old (children father)
    let updatedFather = father {children = removedChildren ++ [child]}
    let removedTreeMember = remove father (treeMembers ft)
    ft {treeMembers = removedTreeMember ++ [updatedFather]}

updateMother :: FamilyTree -> String -> String -> Maybe String -> FamilyTree
updateMother tree old child Nothing = tree
updateMother ft old child (Just motherName) = do
    let mother = fromJust (get_family_member motherName (treeMembers ft))
    let removedChildren = remove old (children mother)
    let updatedMother = mother {children = removedChildren ++ [child]}
    let removedTreeMember = remove mother (treeMembers ft)
    ft {treeMembers = removedTreeMember ++ [updatedMother]}

updateSpouse :: FamilyTree -> String -> String -> Maybe String -> FamilyTree
updateSpouse tree old child Nothing = tree
updateSpouse ft old member (Just spouseName) = do
    let spouse = fromJust (get_family_member spouseName (treeMembers ft))
    let updatedSpouse = spouse {spouse = (Just member)}
    let removedTreeMember = remove spouse (treeMembers ft)
    ft {treeMembers = removedTreeMember ++ [updatedSpouse]}

            
updateChildren :: FamilyTree -> String -> String -> [String] -> FamilyTree
updateChildren tree old new [] = tree
updateChildren tree old new children = do
    let oldMember = fromJust (get_family_member old (treeMembers tree))
    let memberChildren = map(\child -> fromJust (get_family_member child (treeMembers tree))) children
    let removedChildren = (treeMembers tree) \\ memberChildren
    let newChildren = map (\child -> if (gender oldMember == "male") then (child {father = Just new}) else child {mother = Just new}) memberChildren 
    tree{treeMembers = removedChildren ++ newChildren}
          
