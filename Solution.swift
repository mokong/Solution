class Solution {
    // 两数之和，给指定的数，找到数组中两数之和为给定数的 index
    /**
    index, value 遍历数组
    如果 target - value 在字典中，则返回字典中的index和当前index
    如果不存在，则存储当前值和 index，dict[value] = index
    */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int: Int]()
        for (index, value) in nums.enumerated() {
            if let lastIndex = dict[target - value] {
                return [lastIndex, index]
            } 
            dict[value] = index
        }
        return []
    }

    // 字母异位词分组
    // 输入: strs = ["eat", "tea", "tan", "ate", "nat", "bat"]
    // 输出: [["bat"],["nat","tan"],["ate","eat","tea"]]
    // 1. 将字符串转成字符数组，然后排序，再转成字符串，作为 key；比如"eat"、"tea"、"ate"，排序后都是"aet"；
    // 2. 如果字典中存在 key，则把当前字符串加入到对应的数组中
    // 3. 如果不存在，则创建一个数组，将当前字符串加入到数组中
    // 4. 最后返回字典中的 value
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var dict = [String: [String]]()
        for str in strs {
            let key = String(str.sorted())
            if let _ = dict[key] {
                dict[key]?.append(str)
            } else {
                dict[key] = [str]
            }
        }
        return dict.values.map { $0 }
    }


    // 最长连续序列
    /**
    输入：nums = [100,4,200,1,3,2]
    输出：4
    解释：最长数字连续序列是 [1, 2, 3, 4]。它的长度为 4。
    */
    // 理解题目的意思，不需要单个数里每个元素判断，而是数组里每个元素判断，比如 100，要看做一个数，而不是拆分为 1 0 0；
    // 其次是，理解连续序列的意思，比如上面的[100, 4, 200, 1, 3, 2]，最长的连续的序列就是[1, 2, 3, 4];
    // 而如果是[1, 2, 4, 5, 6]， 最长的连续序列就是[4, 5, 6]。这样就理解了题目意思
    // 然后来看解法
    // 解法一：从小到大排序，然后放入 set 中，从小的开始，如果+1 在set 中，则最长序列+1，如果不在则重置
    // 解法二：将数组放入 set 中，遍历，如果当前值-1 不在数组中，则说明是起始值，开始+1 遍历；当前值-1 在 set 中，则忽略，因为判断中的当前值+1 会计算到这个值
    func longestConsecutive(_ nums: [Int]) -> Int {
         let numSet = Set(nums)
         var longestStreak = 0
         for num in numSet {
            if !numSet.contains(num - 1) {
                var currentNum = num
                var currentStreak = 1
                while numSet.contains(currentNum + 1) {
                    currentNum += 1
                    currentStreak += 1 
                }
                longestStreak = max(longestStreak, currentStreak)
            }
         }
         return longestStreak
    }
}