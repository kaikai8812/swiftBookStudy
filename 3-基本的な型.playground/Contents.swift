import UIKit
import Foundation
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

//
////Optional型についてーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
//
//let none = Optional<Int>.none
//print(".none: \(String(describing: none))")
//
//let some1 = Optional<String>.some("サンプル")
//print(".some: \(String(describing: some1))")
//print(some1)
//
////型推論で、プレースホルダ型の中身が、自動的に判別される。
//let some2 = Optional.some(10)
//let some3 = Optional.some("サンプルです")
//
////Optional型の値の生成
//var optional:Int?
//optional = nil  //nilリテラルを代入して、.noneを作成
//optional = Optional(10)  //イニシャライザによる、.someの作成
//optional = 120  //値の代入による、.someの作成
//type(of: optional)
//
//
////Optional型は、値を持っていない可能性があるため,Int？型のデータは四則演算ができない
//var number1:Int? = 10
//var number2:Int? = 20
//var string:String
//
////number1 + number2  //普通にやると、エラーが発生する。
//
////強制アンラップ
//number1! + number2!  //エラーがコンパイル時に発生しなくなるので、使い勝手はいいが、実行時にエラーが生じる可能性もあるので、使用には注意すること。
//
////オプショナルバインディング
////if文を用いて、オプショナル型のの中身が存在していることを保証できている状態を作ると、処理を行うことができる。
//if let optionalNumber1 = number1, let optionalNumber2 = number2 {
//    optionalNumber1 + optionalNumber2
//}
//
//// ??演算子を用いて、Optional型に値が存在しない場合のデフォルト値を設定する。
//let optionalInt:Int? = nil
//let Int = optionalInt ?? 100  //optionalIntの値がない場合は、デフォルト値である100が代入される。
//
////オプショナルチェイン ・・・アンラップをせずに、Wrapped型のメンバーにアクセスする方法
//
//let optionalDouble = Optional(1.0)
//let optionalIsInfinite = optionalDouble?.isInfinite //オプショナル型のデータに「?」をつけることで、Wrapped型のメンバーを使用することができるようになる。
//
////map(_:)メソッドと、flatmap(_:)メソッド
//
////mapメソッド
//let a = Optional(20)
//let b = a.map { value in value * 2}
//print(b)
//type(of: b)
//
//let c = a.map { value in String(value) }
//print(c)
//type(of: c)
//
//
////暗黙的なアンラップをしたものの取扱
//
//let k:Int? = 10 //ここでのkは、optional型で値が代入されているため、wrapped型のデータを使用したい時は下記のように強制的にアンラップしたり、オプショナルバインディングをしないと、使用することができない。
//
//k! + k!
//
//let j:Int! = 20 //こちらでは、暗黙的に値のアンラップをしているためそのまま値を使用することができるが、値が入っていない場合はプログラムの実行時にエラーが生じるため、あまり使わない方が吉
//
//j + j


//// Any型について ---------------------------------------------------------------------
//
////型固有のメソッドやプロパティを使用することができなくなってしまうため、注意が必要
//let a :Any = 10
//let b :Any = 20

////タプル型について -------------------------------------------------------------------------
//
////複数の型をまとめて一つにまとめることができる。
//
//let tuple :(int:Int, string:String, optionalDouble:Double?)
//
//tuple = (10, "テスト", 1.0)
//print(tuple)
//
////各要素へのアクセス方法
////インデックス番号を利用
//let a = tuple.0
//let b = tuple.1
//let c = tuple.2
//
////要素名を利用
//let d = tuple.string
//
////タプルを利用して、複数の変数を同時に宣言することもできる (これを使えば、if文と併用して、可読性のあるオプショナルバインディングをすることができるかも！)
//
//let (test,sample):(String, Int)
//
//test = "こんにちわ"
//sample = 20
//
////Void型 => 要素の数が０のタプル型のことを言う！

//型のキャスト ----------------------------------------------------------

//アップキャスト　下位の型から、上位の型へキャストすること
let any = "テスト" as Any     //Atring型は、any型を継承しているため、アップキャストできる。

//ダウンキャスト

//as?を用いた場合    as?演算子は、ダウンキャストが失敗した場合は、nilを返す。
let sample = 1 as Any

let int1 = sample as? Int
let string1 = sample as? String  //Any型の「1」という値は、String型のProtocolに準拠していないため、nilが返される。

//as!を用いた場合は、ダウンキャストが失敗した場合は、nilを代入するのではなく、プログラム実行時にエラーを生じる。

let int2 = sample as! Int
//let string2 = sample as! String //ダウンキャストに失敗するので、エラーが生じる。

//型の判定
//int2が、Int型カラムどうかを判定するための式
if int2 is Int {
    print("正解")
}
