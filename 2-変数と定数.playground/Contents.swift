import UIKit

//値の返却のみを扱う式

//リテラル式　ー　値を直接プログラムに表記する式

let number = 10 //型推論により、自動的に型を定義してくれている。
let string = "こんにちわ"

//type(of: 変数or定数)で、型を返す

type(of: number)
type(of: string)


//メンバー式　ー　型のメンバー　・・・型に紐づく変数、定数、関数などのこと。
//値に紐づく変数や定数を、プロパティ、型に紐づく関数のことをメソッドという。
let member = "hello,member"
member.count //これはプロパティ
member.starts(with: "hello")  //これは、メソッド
//メソッドは、オブジェクトに対し操作を行い、プロパティはオブジェクト固有のデータを表す。


//クロージャ式
//代表的な書き方　=> { 引数　in 戻り値を返す式}
let original = [1,2,3]
let doubled = original.map { value in
    value * 2
}  //mapメソッドによって、配列の各要素がvalueに代入され、2倍にした後、返り値としてdoubled配列に渡している。

