import UIKit

//数値型に関して

//様々なビット数の整数型が表すことのできる最大値
let a = Int8.max
let b = Int16.max
let c = Int32.max
let d = Int64.max

//浮動小数点型は、値が無限大かどうかを表すinfinityプロパティを持っている。
let e:Double = 1.0 / 0.0
let f:Double = Double.infinity
e.isInfinite //値が無限大だったら、trueを返す。
f.isInfinite

//イニシャライザを用いて、数字の型を変換する
let g:Double = 3.789
let h:Int = Int(g)  //浮動小数点型から整数型に変換をすると、返還後の方の端数に合わせて値が調整される（必ず切り下げされる）

