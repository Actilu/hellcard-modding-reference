**The displayed counter does not update correctly when using `BCCGInfluencePushCardBlock` and not using the default counter:**

It seems to be always one step behind the current counter in code.

| Card played | Expected Displayed Inf Count | Actual Displayed Inf Count | Debug Value (counter - val) |
| ----------- | ---------------------------- | -------------------------- | --------------------------- |
| nothing     | 0                            | 0                          |                             |
| push inf        | 1                            | 1                          | 1 - 1                       |
| push inf        | 2                            | 1                          | 1 - 2                       |
| push inf        | 3                            | 2                          | 2 - 3                       |
| push inf        | 4                            | 3                          | 3 - 4                       |
| push inf        | x                            | x-1                          | x-1 - x                       |

It only happens when using the `BCCGInfluencePushCardBlock` and not while setting counter in code with `influence.SetCounter(counter);`.