/*:
 # Swifty Algorithms
 
 Exploration of algorithms inspired by (abeit an older edition) of Wayne Bishop's [Swift Algorithms and Data Structures](https://shop.waynewbishop.com/collections/2017-swift-algorithms-catalog/products/swift-algorithms-3rd-edition?variant=44574663061).
 
 Thrown together by: Jennifer Starratt

 ### Binary Search (Iterative)
*/
var searchInput = [1, 2, 4, 8, 10, 34]

func binarySearch<T: Comparable>(array: Array<T>, for target: T) -> Bool {
    // Get indices.
    var min = array.startIndex
    var max = array.endIndex
    
    // Until we overlap,
    while (min <= max) {
        // Get middle.
        let midIndex = (min + max) / 2
        let mid = array[midIndex]
        
        if target < mid {
            // If we need to look more to the left,
            max = midIndex.advanced(by: -1)
        } else if target > mid {
            // Otherwise we need to look to the right.
            min = midIndex.advanced(by: 1)
        } else {
            return true
        }
    }
    
    return false
}

binarySearch(array: searchInput, for: 5)
/*:
 #### Binary Search (Recursive)
 */
func recursiveBinarySearch<T: Comparable>(array: Array<T>, for target: T) -> Bool {
    // First get indices.
    guard let max = array.max(), let min = array.min() else { return false }
    let midIndex = (array.startIndex + array.endIndex) / 2
    let mid = array[midIndex]
    
    // Check bounds (since indices change, we need to make sure it is still worth looking).
    guard target <= max && target >= min else { return false }
    
    // Evaluate the new range.
    if target > mid {
        let newBound = midIndex.advanced(by: 1)
        return recursiveBinarySearch(array: Array(array[newBound...]), for: target)
    } else if target < mid {
        let newBound = midIndex.advanced(by: -1)
        return recursiveBinarySearch(array: Array(array[...newBound]), for: target)
    } else {
        return true
    }
}

recursiveBinarySearch(array: searchInput, for: 5)
/*:
 #### Insertion Sort
*/
var sortInput = [2, 1, 9, 6, 22, -1]

func insertionSort<T: Comparable>(array: Array<T>) -> Array<T> {
    // Mutated copy since argument is a `let`
    // This makes array our "invariant".
    var output = array
    
    // For each index.
    for index in output.indices {
        
        // Grab its value.
        let item = output[index]
        
        // Compare to each prior index,
        for priorIndex in output.indices[0..<index].reversed() {
            
            // If the value is less than the previous one, (and thus not ordered correctly).
            if item < output[priorIndex] {
            
                // Remove it from its current spot.
                output.remove(at: priorIndex + 1)
                
                // Insert it one over (which will be evaluated next).
                output.insert(item, at: priorIndex)
            }
        }
    }
    
    return output
}

insertionSort(array: sortInput)
/*:
 #### Bubble Sort
 */
func bubbleSort<T: Comparable>(array: Array<T>) -> Array<T> {
    // Mutated copy since argument is a `let`
    // This makes array our "invariant".
    var output = array
    
    // For each index in the array,
    for _ in array.indices {
        
        // Bubble it up until it is in the right spot
        // (Note the dropLast because we will do (index + 1))
        for index in array.indices.dropLast() {
            
            // If the left one is more, then swap it.
            if output[index] > output[index + 1] {
                output.swapAt(index, index + 1)
            }
        }
    }
    
    return output
}

bubbleSort(array: sortInput)
/*:
 #### Selection Sort
 */
func selectionSort<T: Comparable>(array: Array<T>) -> Array<T> {
    // Mutated copy since argument is a `let`
    // This makes array our "invariant".
    var output = array
    
    // For each index,
    for primaryIndex in array.indices {
        
        // Assume initial index is minimum of what's left.
        var minimumIndex = primaryIndex
        
        // For each of the remaining bits,
        for comparingIndex in array.indices.dropFirst(primaryIndex) {
            
            // Look for the real minimum index.
            if output[minimumIndex] > output[comparingIndex] {
                minimumIndex = comparingIndex
            }
        }
        
        // Now that we have the minimum index, swap with current.
        output.swapAt(primaryIndex, minimumIndex)
    }
    
    return output
}

selectionSort(array: sortInput)
