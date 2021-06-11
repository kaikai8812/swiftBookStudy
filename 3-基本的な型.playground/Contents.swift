//import UIKit
//import Foundation
////数値型に関してーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
//
////様々なビット数の整数型が表すことのできる最大値
//let a = Int8.max
//let b = Int16.max
//let c = Int32.max
//let d = Int64.max
//
////浮動小数点型は、値が無限大かどうかを表すinfinityプロパティを持っている。
//let e:Double = 1.0 / 0.0
//let f:Double = Double.infinity
//e.isInfinite //値が無限大だったら、trueを返す。
//f.isInfinite
//
////イニシャライザを用いて、数字の型を変換する
//let g:Double = 3.789
//let h:Int = Int(g)  //浮動小数点型から整数型に変換をすると、返還後の方の端数に合わせて値が調整される（必ず切り下げされる）
//
////Foudationライブラリを使用することで、円周率や三角関数、対数関数などを使用することができる。
//
//Float.pi //円周率を表す
//log(100.0)
//


//文字列関係ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

////複数の文字列を表現する時は、スリーダブルクオートを使用する
////スリーダブルクオートと同じ行にコードは書いてはいけない。
//let haiku = """
//    広がる
//        私の
//            世界
//    """      //ここの行からのインデントの数が実際に出力される時に反映される。
//
//"abcde".range(of: "de")


//Optional型についてーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

let none = Optional<Int>.none
print(".none: \(String(describing: none))")

let some1 = Optional<String>.some("サンプル")
print(".some: \(String(describing: some1))")
print(some1)

//型推論で、プレースホルダ型の中身が、自動的に判別される。
let some2 = Optional.some(10)
let some3 = Optional.some("サンプルです")

//Optional型の値の生成
var optional:Int?
optional = nil  //nilリテラルを代入して、.noneを作成
optional = Optional(10)  //イニシャライザによる、.someの作成
optional = 120  //値の代入による、.someの作成
type(of: optional)


//Optional型は、値を持っていない可能性があるため,Int？型のデータは四則演算ができない
var number1:Int? = 10
var number2:Int? = 20
var string:String

//number1 + number2  //普通にやると、エラーが発生する。

//強制アンラップ
number1! + number2!  //エラーがコンパイル時に発生しなくなるので、使い勝手はいいが、実行時にエラーが生じる可能性もあるので、使用には注意すること。

//オプショナルバインディング
//if文を用いて、オプショナル型のの中身が存在していることを保証できている状態を作ると、処理を行うことができる。
if let optionalNumber1 = number1, let optionalNumber2 = number2 {
    optionalNumber1 + optionalNumber2
}

// ??演算子を用いて、Optional型に値が存在しない場合のデフォルト値を設定する。
let optionalInt:Int? = nil
let Int = optionalInt ?? 100  //optionalIntの値がない場合は、デフォルト値である100が代入される。
