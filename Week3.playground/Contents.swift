// MARK: Monday
var testArray = [0,1,2,3,4,5,6,7,8,9,10]
var testArray2 = [3,6,2,7,24,6,1,89,3,4]
var testArray3 = [3,6,2,7,24,6,5,89,3,4]

func highAndLowInt(numArray : [Int]) -> (highNumber : Int, lowNumber : Int) {
  //Initliaze with value in the array
  var highestNumber : Int = numArray[0]
  var lowestNumber : Int = numArray[0]

  for i in numArray {
    
    //Test for highest number
    if i > highestNumber {
      highestNumber = i
    }
    
    //Test for lowest number
    if i < lowestNumber {
      lowestNumber = i
    }
    
  }

  return (highestNumber, lowestNumber)
}

highAndLowInt(testArray)
highAndLowInt(testArray2)
highAndLowInt(testArray3)


//MARK: Tuesday
let TestArray4 = [0,1,2,3,4]
let TestArray5 = [0,1,2,3,4,5,6]

func returnMiddleIndex(arr : [Int]) -> [Int] {
  var arrToFix = arr
  
  // Remove Last Index
  arrToFix.removeAtIndex(arr.count - 1)
  // Remove First Index
  arrToFix.removeAtIndex(0)

  
  return arrToFix
}

let returnArray = returnMiddleIndex(TestArray4)
let returnArray2 = returnMiddleIndex(TestArray5)

//MARK: Wednesday
func almostMultipeOfTen(x : Int) -> Bool {
  
  if x % 10 <= 2 {
    return true
  } else if x % 10 >= 8 {
    return true
  } else {
    return false
  }
}

almostMultipeOfTen(13)
almostMultipeOfTen(12)
almostMultipeOfTen(9)
almostMultipeOfTen(8)
almostMultipeOfTen(7)
almostMultipeOfTen(24)
almostMultipeOfTen(22)
almostMultipeOfTen(19)


//Mark: Thursday

func doubleLetters(stringToEdit : String) -> String {
    let arrayFromString = Array(stringToEdit)
    
    
    
    
    return "string"
}


 
