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
( ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ )

stub rem

{
  stub r      ( refresh )
  stub q      ( input   )
  stub p      ( prev    )
  stub n      ( next    )
  stub v      ( view    )
  variable l  ( line    )
  variable c  ( column  )

  here is p ] blk -- ;
  here is n ] blk ++ ;

  : up l -- ; : dn l ++ ;
  : lt c -- ; : rt c ++ ;

  : match: ` char: ` over ` =if ; immediate
  : bounds ( - )
    c @ -1 =if 63 c ! dn then
    c @ 64 =if  0 c ! up then
    l @ -1 =if  0 l ! p then
    l @  8 =if  0 l ! n then
    blk @ -1 =if 0 s then
  ;

  {
    : pos  ( -cl)  c @ l @ ;
    : get  ( cl-a) (line) + ;
    : addr ( -a )  pos get ;
    : va   ( a-va) dup @ swap ;
    : c!   ( a-)   char: * swap ! ;
    : show ( va- ) dup c! (v) ! ;
    : wr   ( n- ) bounds addr ! ;
    here is r ] v cr pos . . ;
    here is v ] ( - ) addr va show ;
    here is q ] ( n-n )
      key
      dup 27 =if ;then
      dup 10 =if ;then
      dup 8  =if lt 32 wr r q ;then
      wr rt r q ;
  }

  here is rem ]
    repeat
      r key
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
