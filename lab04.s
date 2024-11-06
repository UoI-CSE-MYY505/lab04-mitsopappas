
.globl str_ge, recCheck

.data

maria:    .string "Maria"
markos:   .string "Markos"
marios:   .string "Marios"
marianna: .string "Marianna"

.align 4  # make sure the string arrays are aligned to words (easier to see in ripes memory view)

# These are string arrays
# The labels below are replaced by the respective addresses
arraySorted:    .word maria, marianna, marios, markos

arrayNotSorted: .word marianna, markos, maria

.text

            la   a0, arrayNotSorted
            li   a1, 4
            jal  recCheck

            li   a7, 10
            ecall

str_ge:
#---------
# Write the subroutine code here
#  You may move jr ra   if you wish.
#---------
            jr   ra
 
# ----------------------------------------------------------------------------
# recCheck(array, size)
# if size == 0 or size == 1
#     return 1
# if str_ge(array[1], array[0])      # if first two items in ascending order,
#     return recCheck(&(array[1]), size-1)  # check from 2nd element onwards
# else
#     return 0

recCheck:
#---------
recCheck:
            slti t0, a1,   2
            beq  t0, zero, checkFirstTwo
            addi a0, zero, 1  # return 1
            jr   ra
checkFirstTwo:
            addi sp, sp,   -12
            sw   ra, 8(sp)
            sw   a0, 4(sp)
            sw   a1, 0(sp)
            lw   a1, 0(a0)  # 1st
            lw   a0, 4(a0)  # 2nd 
            jal  str_ge
            beq  a0, zero, return  # return 0, a0 is already 0
            # do recursion
            lw   a0, 4(sp)    # get original a0, a1 from stack
            lw   a1, 0(sp)
            addi a0, a0,   4   # check the rest of the array, after 1st element.
            addi a1, a1,   -1  # size-1
            jal  recCheck
return:
            lw   ra, 8(sp)
            addi sp, sp,   12
            jr   ra
#---------
            jr   ra
