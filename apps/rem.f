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
  stub v      ( view   )
  variable l  ( line   )
  variable c  ( column )

  {
    : pos  ( -cl)  c @ l @ ;
    : get  ( cl-a) (line) + ;
    : va   ( a-va) dup @ swap ;
    : c!   ( a-)   char: * swap ! ;
    : show ( va- ) dup c! (v) ! ;
    here is v ] ( - ) pos get va show ;
  }


  : match: ` char: ` over ` =if ; immediate
  : bounds ( - )
    c @ -1 =if 63 c ! l -- then
    c @ 64 =if  0 c ! then
    l @ -1 =if  0 l ! p then
    l @  8 =if  0 l ! n then
    blk @ -1 =if 0 s then
  ;

  here is rem ]
    repeat
      v cr l @ . c @ .
      key
      match: i  l -- bounds then
      match: j  c -- bounds then
      match: k  l ++ bounds then
      match: l  c ++ bounds then
      match: p  p           then
      match: n  n           then
      match: q  c @ l @ ia  then
      match: z  drop       ;then
      drop
    again
  ;
}
