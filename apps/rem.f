( ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ )
( Retro Editor for Mortals ["rem"]                          )
( ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ )
( Distributed under the Creative Commons Zero License:      )
(                                                           )
( The person who associated a work with this document has   )
( dedicated this work to the Commons by waiving all of his  )
( or her rights to the work under copyright law and all     )
( related or neighboring legal rights he or she had in the  )
( work, to the extent allowable by law.                     )
(                                                           )
( Other Rights — In no way are any of the following rights  )
( affected by CC0:                                          )
(  * Patent or trademark rights held by the person who      )
(    associated this document with a work.                  )
(  * Rights other persons may have either in the work       )
(    itself or in how the work is used, such as publicity   )
(    or privacy rights.                                     )
(                                                           )
( Charles Childers, December 2009                           )
( Luke Parrish, December 2009                               )
( ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ )

stub rem

{
  stub r      ( refresh )
  stub q      ( input   )
  stub v      ( view    )
  variable l  ( line    )
  variable c  ( column  )

  stub b      ( backspace )
  stub s      ( space     )
  stub m      ( return    )

  : p ( - ) blk -- ;  ( previous )
  : n ( - ) blk ++ ;  ( next     )

  : up ( - ) l -- ;
  : dn ( - ) l ++ ;
  : lt ( - ) c -- ;
  : rt ( - ) c ++ ;

  : top ( - ) 0 l ! ;
  : bot ( - ) 7 l ! ;
  : beg ( - ) 0 c ! ;
  : end ( - ) 63 c ! ;
  : mid ( - ) 31 c ! ;

  : match-num ( n- )
    ` over ` =if ; immediate
  : match: ( "- )
    ` char: ` match-num ; immediate
  : alias-num: ( n"- )
    ` match-num ` char: ; immediate

  : bounds ( - )
    c @ -1 =if end up then
    c @ 64 =if beg dn then
    l @ -1 =if top p then
    l @  8 =if bot n then
    blk @ -1 =if 0 s then
    blk @ #-blocks @ >if blk -- then
  ;

  {
    : pos  ( -cl  )  c @ l @ ;
    : get  ( cl-a )  (line) + ;
    : addr ( -a   )  pos get ;
    : va   ( a-va )  dup @ swap ;
    : c!   ( a-   )  char: * swap ! ;
    : show ( va-  )  dup c! (v) ! ;
    : wr   ( n-   )  bounds addr ! ;
    : ws   ( -    )  whitespace off later whitespace on ;
    here is r ] v cr pos . . ;
    here is v ] ( - ) addr va show ;
    here is b ] lt 32 wr r ;
    here is s ] 32 wr rt ;
    here is m ] dn beg ;
    here is q ] ( n-n )
      ws
      repeat
        key
        dup 27 =if drop ;then
        dup 8  =if b drop ;then
        dup 10 =if drop m r else wr rt r then
      again ;
  }

  : arr ( k-k )
    match: j lt then match: l rt then
    match: i up then match: k dn then ;

  : rep ( n-k )
    key swap 49 - for arr next bounds ;
    
  here ] ( c-c ) dup 9 =if drop 27 then ; is (remap-keys)

  here is rem ]
    repeat
      r key
      dup 48 >if dup 58 <if rep then then
      27 alias-num: q  then
      8  alias-num: b  then
      32 alias-num: s  then
      10 alias-num: m  then
      arr
      match: I  top    then
      match: J  beg    then
      match: K  bot    then
      match: L  end    then
      match: M  mid    then
      match: p  p      then
      match: n  n      then
      match: q  q      then
      match: b  b      then
      match: s  s      then
      match: m  m      then
      match: z  drop  ;then
      bounds
      drop
    again
  ;
}
