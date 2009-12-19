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

  : p ( - ) blk -- ;  ( previous )
  : n ( - ) blk ++ ;  ( next     )

  : up ( - ) l -- ;
  : dn ( - ) l ++ ;
  : lt ( - ) c -- ;
  : rt ( - ) c ++ ;

  : match-num ( n- )
    ` over ` =if ; immediate
  : match: ( "- )
    ` char: ` match-num ; immediate
  : alias-num: ( n"- )
    ` match-num ` char: ; immediate

  : bounds ( - )
    c @ -1 =if 63 c ! up then
    c @ 64 =if  0 c ! dn then
    l @ -1 =if  0 l ! p then
    l @  8 =if  0 l ! n then
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
    here is r ] v cr pos . . ;
    here is v ] ( - ) addr va show ;
    here is q ] ( n-n )
      repeat
        key
        dup 27 =if drop ;then
        dup 8  =if drop lt 32 wr r q ;then
        wr rt r
      again ;
  }

  here is rem ]
    repeat
      r key
      27 alias-num: q  then
      match: i  up     then
      match: j  lt     then
      match: k  dn     then
      match: l  rt     then
      match: p  p      then
      match: n  n      then
      match: q  q      then
      match: z  drop  ;then
      bounds
      drop
    again
  ;
}
