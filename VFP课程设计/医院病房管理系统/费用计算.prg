*计算患者住院费用
proc 费用计算
para pay,sum1,kk,kj,pay1,sum2
kk=200*kj+summ(@pay,sum1,@pay1,sum2)
function summ
para payy,summm,payy1,summm1
store 0 to kkk
for i=1 to 2*summm-1 step 2
kkk=kkk+payy(i)*payy(i+1)
endfor
for i=1 to 2*summm1-1 step 2
kkk=kkk+payy1(i)*payy1(i+1)
endfor
return kkk
endfunc
endproc