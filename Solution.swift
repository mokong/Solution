class Solution {

    // 无重复字符的最长子串
    // 首先理解题目，无重复字符，最长子串，一共两个要求，一个是无重复字符，一个是最长子串，所以可以理解为，找到一个最长的子串，然后判断这个子串是否是无重复字符的子串，如果无重复字符，则返回这个子串的长度，如果存在重复字符，则返回0。
    // 暴力法
    // 时间复杂度：O(n^3)
    // 空间复杂度：O(1)
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if (s.isEmpty) {
            return 0;
        }

        var res = 0;
        var start = 0;
        let count = s.count;
        var dic = [Character: Int]()
        let sArr: [Character] = Array(s);
        for i in 0..<count {
            let alpha = sArr[i];
            if dic[alpha] != nil {
                start = max(start, dic[alpha]! + 1);
            }
            res = max(res, i - start + 1);
            dic[alpha] = i;
        }
        return res;
   }


    // 三数之和
    // 暴力法
    // 时间复杂度：O(n^3)
    // 空间复杂度：O(1)
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        let n = nums.count
        for i in 0..<n {
            for j in i+1..<n {
                for k in j+1..<n {
                    if nums[i] + nums[j] + nums[k] == 0 {
                        // 去重
                        let list = [nums[i], nums[j], nums[k]].sorted()
                        if res.contains(list) == false {
                            res.append(list)
                        }
                    }
                }
            }
        }        
        return res
    }

    // 再来看另一种解法，
    // 思路是先对数组排序，然后固定一个数，然后使用双指针法，遍历数组
    // 然后移动指针，如果和大于0，则移动左指针，如果和小于0，则移动右指针，如果等于0，则将结果加入到结果集中，然后移动指针
    // 时间复杂度是O(n^2)，空间复杂度是O(1)
    // 然后再来看判断去重条件
    // 如果固定数大于0，则后面的数不可能有解，所以直接返回结果集
    // 由于数组是排序好的，所以当固定的数 > 0 时，说明后面的数字都 > 0，不可能存在 == 0的结果，就可以终止遍历了
    // 当获取到 = 0集合时，可以遍历判断相邻元素是否相等，如果相等，说明是重复的，跳过即可
    // 当当前 == 0，结果存储，跳过重复的之后，左指针右移，右指针左移，继续判断
    func threeSum2(_ nums: [Int]) -> [[Int]] {
        var res: [[Int]] = []
        let sortedNums = nums.sorted()
        for i in 0..<sortedNums.count {
            // 固定数大于0，则后面的数不可能有解，所以直接返回结果集
            if sortedNums[i] > 0 {
                break
            }

            // i > 0 的判断是为了判断当前固定数和前一个数是否相等，如果相等，则跳过
            if i > 0 && sortedNums[i] == sortedNums[i - 1] {
                // 去重
                continue
            }
            var left = i + 1
            var right = sortedNums.count - 1
            while left < right {
                let sum = sortedNums[i] + sortedNums[left] + sortedNums[right]
                if sum == 0 {
                    // 当前的结果，可以存储
                    res.append([sortedNums[i], sortedNums[left], sortedNums[right]])
                    // 去重
                    // 由于数组排序了，所以，如果当前元素和下一个元素相等，则说明是重复的，跳过即可
                    while (left < right) && (sortedNums[left] == sortedNums[left + 1]) {
                        left += 1
                    }
                    while (left < right) && (sortedNums[right] == sortedNums[right - 1]) {
                        right -= 1
                    }
                    // 同时移动左指针和右指针，继续遍历
                    left += 1
                    right -= 1
                } else if sum > 0 {
                    // 数组是有序的，结果大于 0，说明右边的数大了，所以右边指针向左移动
                    right -= 1
                } else {
                    // 结果小于 0，说明左边的数字小了，所以左边指针向右移动
                    left += 1
                }
            }
        }
        return res
    }


    // 盛最多水的容器
    // 首先需要明确：求解最大面积，那么求解的变量应该是面积，面积的计算公式 最小的高 * 宽，即：min(height[i], height[j]) * (j - i)
    // 然后来思考有哪些解法
    // 解法1: 暴力法，两层循环，计算每个位置的左右指针，计算当前面积，然后更新最大面积
    // 时间复杂度：O(n^2)
    // 空间复杂度：O(1)
    func maxArea(_ height: [Int]) -> Int {
        var maxAreaValue = 0
        for i in 0..<height.count {
            for j in i+1..<height.count {
                let area = min(height[i], height[j]) * (j - i)
                maxAreaValue = max(maxAreaValue, area)
            }
        }
        return maxAreaValue
    }


    // 解法2：双指针，从两端向中间遍历，每次移动指针，计算当前面积，然后更新最大面积
    // 双指针怎么移动，判断的条件是什么？需要思考明白，由于高度是递增的，所以每次移动指针，高度较小的指针移动，高度大的指针不动，这样，每次移动指针，计算面积，然后更新最大面积，直到左右指针相遇
    // 时间复杂度：O(n)
    // 空间复杂度：O(1)
    func maxArea2(_ height: [Int]) -> Int {
        var maxArea = 0
        var left = 0
        var right = height.count - 1
        while left < right {
            let area = min(height[left], height[right]) * (right - left)
            maxArea = max(maxArea, area)
            // 由于高度是递增的，所以每次移动指针，高度较小的指针移动，高度大的指针不动，这样，每次移动指针，计算面积，然后更新最大面积，直到左右指针相遇
            if height[left] < height[right] {
                left += 1
            } else {
               right -= 1
           }
       }
       return maxArea
   }


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

    // 移动零
    /**
    给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
    输入：nums = [0,1,0,3,12]
    输出：[1,3,12,0,0]
    */
    // 解法 1：遍历数组每一个元素，如果是 0，则删除，然后插入到数组末尾，然后继续遍历；
    // 解法 2：把所有不是 0 的元素，从头依次放入数组中，并记录有多少不为 0 的元素；最后把数组剩余位置补 0；

    // 但是解法 1 如果按照下面的写法就会发现结果不通过？为什么呢？乍一看逻辑没有问题，但是在 for 循环中，如果删除了某个元素，导致位置发生了变化，然后还是按照初始数组的顺序遍历，就会导致结果不对；
    // 比如：起始数组为[0, 0, 1]
    // i = 0时，运行后数组变为了[0, 1, 0]
    // 然后继续 i = 1 时，运行后数组还是[0, 1, 0]
    // 然后 i = 2，运行后数组还是[0, 1, 0]
    // 最终结果就不对了
    func moveZeroes1_Wrong(_ nums: inout [Int]) {
        for i in 0..<nums.count {
            if nums[i] == 0 {
                nums.remove(at: i)
                nums.append(0)
            }
        }
    }

    // 所以如果想要按照解法 1，移动 0 来实现，需要每次遍历遇到 0 时，i 保持上一次 i 的值；遇到非 0 的值，i += 1；同时保证总共的遍历次数为数组的长度。实现如下：
    func moveZeroes1(_ nums: inout [Int]) {
        let count = nums.count
        var compareCount = 0
        var i = 0
        while compareCount < count {
            if nums[i] == 0 {
                nums.remove(at: i)
                nums.append(0)
            } else {
                i += 1
            }
            compareCount += 1
        }
    }

    // 解法 2 的实现如下
    func moveZeroes(_ nums: inout [Int]) {
        var index = 0
        for i in 0..<nums.count {
            if nums[i] != 0 {
                nums[index] = nums[i]
                index += 1
            }
        }
        for i in index..<nums.count {
            nums[i] = 0
        }
    }
}